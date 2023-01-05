class SeatController < ApplicationController

    # def initialize (
    #     seats: seats,
    #     passengers: passengers
    # )
    #     @seats = seats
    #     @passengers = passengers
    # end

    # def initialize
    #     @seats = [[3,2], [4,3], [2,3], [3,4]]
    #     @passengers = 30
    # end

    # def seat_verification
    #     total_seats = 0
    #     verify_seat = true
    #     @seats.map { |seat|
    #         if verify_seat
    #             unless seat.length == 2 or seat.include? 0 || nil
    #                 verify_seat = false
    #             end
    #             total_seats += seat.inject(:*)
    #         end
    #     }
    #     print verify_seat
    #     print total_seats < @passengers
    #     unless verify_seat
    #         print "Seat Error"
    #         render json: {}, status: :unprocessable_entity and return
    #         # flash[:alert] = "Seating Error"
    #     else
    #         print "Seats Verified"
    #     end
    # end



    def index
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
    end

    def show
    end
end
