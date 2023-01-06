class SeatController < ApplicationController
    def index
        print "Hello World"
    end
    def show
        params = self.params
        seats = JSON.parse(params["seats"])
        passengers = params["passengers"].to_i

        seat_planner = SeatPlanner.new( seats, passengers )
        if seat_planner.seat_verification
            payload = Hash.new
            plane_layout = seat_planner.plan_seat
            
            payload = {
                "plane_layout": plane_layout
            }
            render json: payload, status: :ok
        else
            render json: {}, status: :unprocessable_entity
        end
    end
end
