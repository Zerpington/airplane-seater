class SeatPlanner
    def initialize(seats, passengers)
        @seats = seats
        @passengers = passengers
    # def initialize
    #     @seats = [[3,2], [4,3], [2,3], [3,4]]
    #     # 36seats
    #     @passengers = 30
        # @seats = [[3, 2], [3, 2]]
        # @passengers = 12

        # @seats = [[1, 3]]
        # @seats = [[3,4], [4,3], [2,3], [3,2]]
        # possible test cases for later
        # @seats = [[3,2], [4,3], [2,3], [0, 1]]
        # @seats = [[3,2], [4,3], [2,3], [2, nil]]
        # @seats = [[3,2], [4,3], [2,3], [2]]
        # @seats = [[3,2], [4,3], [2,3], [1, "a"]]
        # @seats = ["12", [4,3], [2,3], [1, "a"]]
    end

    def seat_verification
        total_seats = 0
        @seats.map do |seat|
            unless seat.is_a? Array
                print "Error: Seat Format - Not an Array"
                return false
            end
            unless seat.length == 2
                print "Error: Seat Format - Array length not followed"
                return false
            end
            unless seat.exclude? 0 || nil
                print "Error: Seat Format - Includes 0/nil"
                return false
            end
            unless seat.all? {|i| i.is_a?(Integer) }
                print "Error: Seat Format - Non-Integer"
                return false
            end
            unless seat[0].is_a? Integer
                print "Error: Seat Format - Not an Integer"
                return false
            end
            unless seat[1].is_a? Integer
                print "Error: Seat Format - Not an Integer"
                return false
            end
            total_seats += seat.inject(:*)
        end
        unless @passengers.is_a? Integer
            print "Error: Passengers is not an Integer"  
            return false
        end
        unless total_seats >= @passengers
            print "Error: Too many Passengers"  
            return false
        else
            print "Seats Verified"
            return true
        end
    end

    def row_maker(first, last, seat)
        case seat[0]
        when 1
            row = [first]
        when 2
            row = [first,last]
        else
            middle_seats = seat[0]-2
            row = [first,last]
            middle_seats.times{
                row.insert(1,["M"])
            }
        end
        return row
    end

    def create_block (seat, i)
        block = []
        rows = seat[1]
        # assign seat: W=Window, M=Middle, A=Aisle 
        # seat = [3, 2] = [[[W],[M],[A]],[W],[M],[A]]]

        if @seats.length == 1
            row = row_maker(["W"],["W"], seat)
            @max_rows = seat[1]
        else
            if i == 1
                row = row_maker(["W"],["A"], seat)
            elsif i == @seats.length
                row = row_maker(["A"],["W"], seat)
            else
                row = row_maker(["A"],["A"], seat)
            end
            if seat[1] > @max_rows
                @max_rows = seat[1]
            end
        end
        rows.times{block.push(row)}

        return block
    end

    def create_plane
        @seats.map { |seat| Array.new(seat[1]) { Array.new(seat[0]) } }
    end

    def add_passengers (plane_layout, plane)
        seat_number = 1
        [["A"],["W"],["M"]].each do |seat_type|
            for row in 0..(@max_rows-1) do
                plane_layout.each_with_index do |block, b|
                    next if block[row].nil?
                    block[row].each_with_index do |seat, s|
                        next if seat != seat_type
                        if seat_number <= @passengers
                            plane[b][row][s] = [seat[0], seat_number]
                            seat_number+=1
                        else
                            plane[b][row][s] = [seat[0], nil]
                        end
                    end
                end
            end
        end
        return plane
    end

    def plan_seat
        plane_layout = []
        @max_rows = 0

        @seats.each.with_index(1) do |seat, i|
            block =  create_block(seat, i)
            plane_layout.append(block)
        end

        plane = create_plane
        plane = add_passengers(plane_layout, plane)
        
        return plane
    end
end