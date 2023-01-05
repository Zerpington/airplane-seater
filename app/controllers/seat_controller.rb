class SeatController < ApplicationController
    def index
        if SeatPlanner.new.seat_verification
            payload = Hash.new
            # make new array and stuff
            # W=Window, M=Middle, A=Aisle
            # Goal: [[[G,3],[R, 2],[B,1]],[[G,3],[R, 2],[B,1]]] etc or something
            plane_layout = SeatPlanner.new.plan_seat
            
            payload = {
                "plane_layout": plane_layout
            }

            print payload
            render json: payload, status: :ok
        else
            render json: {}, status: :unprocessable_entity
        end
    end

    def show
    end
end
