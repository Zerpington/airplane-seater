class Api::SeatController < ApplicationController
    def plan_seat
        seats = params["seats"]
        seats = JSON.parse(seats) if seats.is_a? String
        passengers = params["passengers"].to_i
        seat_planner = SeatPlanner.new(seats, passengers)

        result, message =  seat_planner.verify_seats

        if result
            payload = { plane_layout: seat_planner.plan_seat }

            render json: payload, status: :ok
        else
            render json: { error: message }, status: :unprocessable_entity
        end
    end
end
