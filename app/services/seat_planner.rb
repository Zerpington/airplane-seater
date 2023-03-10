class SeatPlanner
    def initialize(seats, passengers)
        @seats = seats
        @passengers = passengers
    end

    def verify_seats
        return [false, "Seats - Not an Array"] unless @seats.is_a? Array 
        return [false, "Passengers is not an Integer"] unless @passengers.is_a? Integer

        total_seats = 0

        @seats.each do |seat|
            unless seat.is_a? Array
                return [false, "Seat Format - Not an Array"]
            end
            if seat.length != 2 
                return [false, "Seat Format - Array length not followed"]
            end
            if seat.any? { |i| !i.is_a?(Integer) || i < 1 }
                return [false, "Seat Format - Array elements not valid"]
            end

            total_seats += seat[0] * seat[1]
        end
        
        return [false, "Too many Passengers"] if total_seats < @passengers
   
        [true, "Success"]
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

    def add_passengers (plane_layout, plane, max_rows)
        seat_number = 1
        [["A"],["W"],["M"]].each do |seat_type|
            for row in 0..(max_rows-1) do
                plane_layout.each_with_index do |block, b|
                    next if block[row].nil?
                    block[row].each_with_index do |seat, s|
                        next if seat != seat_type
                        # assign number to seat else no number
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
        plane = add_passengers(plane_layout, plane, @max_rows)
        
        return plane
    end
end