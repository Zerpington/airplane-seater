class SeatPlanner
    def initialize
        @seats = [[3,2], [4,3], [2,3], [3,4]]
        # possible test cases for later
        # @seats = [[3,2], [4,3], [2,3], [0, 1]]
        # @seats = [[3,2], [4,3], [2,3], [2, nil]]
        # @seats = [[3,2], [4,3], [2,3], [2]]
        # @seats = [[3,2], [4,3], [2,3], [1, "a"]]
        @passengers = 30
    end

    def seat_verification
        total_seats = 0
        @seats.map { |seat|
            unless seat.length == 2
                # render json: {}, status: :unprocessable_entity
                print "Error: Seat Format - Array length not followed"
                return false
            end
            unless seat.exclude? 0 || nil
                # render json: {}, status: :unprocessable_entity
                print "Error: Seat Format - Includes 0/nil"
                return false
            end
            unless seat.all? {|i| i.is_a?(Integer) }
                # render json: {}, status: :unprocessable_entity
                print "Error: Seat Format - Non-Integer"
                return false
            end
            total_seats += seat.inject(:*)
        }
        unless total_seats > @passengers
            print "Error: Too many Passengers"  
            return false
            # flash[:alert] = "Seating Error"
        else
            print "Seats Verified"
            return true
        end
    end

    def block_maker (seat, i)
        # assign seat: W=Window, M=Middle, A=Aisle 
        if i == 1
            # seat = [3, 2] = [[[W],[M],[A]],[W],[M],[A]]]
            case seat[0]
            when 1
                row = [["W"]]
            when 2
                row = [["W"],["A"]]
            else
                middle_seats = seat[0]-2
                row = [["W"],["A"]]
                middle_seats.times{
                    row.insert(1,["M"])
                }
            end
            block = []
            seat[1].times{block.push(row)}
            return block

        elsif i == @seats.length
            case seat[0]
            when 1
                row = [["A"]]
            when 2
                row = [["A"],["W"]]
            else
                middle_seats = seat[0]-2
                row = [["A"],["W"]]
                middle_seats.times{
                    row.insert(1,["M"])
                }
            end

            block = []
            rows = seat[1]
            rows.times{block.push(row)}
            
            return block
        else
            case seat[0]
            when 1
                row = [["A"]]
            when 2
                row = [["A"],["A"]]
            else
                middle_seats = seat[0]-2
                row = [["A"],["A"]]
                middle_seats.times{
                    row.insert(1,["M"])
                }
            end
            block = []
            seat[1].times{block.push(row)}
            return block
        end
    end

    def plan_seat
        plane_layout = []
        @seats.each.with_index(1) do |seat, i|
            block =  block_maker(seat, i)
            plane_layout.append(block)
        end
        return plane_layout
    end

end