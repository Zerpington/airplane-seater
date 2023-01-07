require "rails_helper"

RSpec.describe SeatPlanner do
    let(:seats) { [[3,2], [4,3], [2,3], [3,4]] }
    let(:passengers) { 30 }

    describe "#plan_seat" do
        subject { described_class.new(seats, passengers).plan_seat }

        context "when parameters are correct" do
            let(:result) do
                [
                    [
                        [["W", 19], ["M", 25], ["A", 1]], 
                        [["W", 21], ["M", 29], ["A", 7]]
                    ],
                    [
                        [["A", 2], ["M", 26], ["M", 27], ["A", 3]], 
                        [["A", 8], ["M", 30], ["M", nil], ["A", 9]], 
                        [["A", 13], ["M", nil], ["M", nil], ["A", 14]]
                    ],
                    [
                        [["A", 4], ["A", 5]],
                        [["A", 10], ["A", 11]],
                        [["A", 15], ["A", 16]]
                    ],
                    [
                        [["A", 6], ["M", 28], ["W", 20]], 
                        [["A", 12], ["M", nil], ["W", 22]], 
                        [["A", 17], ["M", nil], ["W", 23]], 
                        [["A", 18], ["M", nil], ["W", 24]]
                    ]
                ]
            end

            it "returns a 2D-array seatplan for the passengers" do
                expect(subject).to eq(result)
            end    
        end
    end

    describe "#create_plane" do
        subject { described_class.new(seats, passengers).create_plane }
        let(:result) do
            [
                [[nil, nil, nil], [nil, nil, nil]],                                                      
                [[nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, nil]],                      
                [[nil, nil], [nil, nil], [nil, nil]],                                                    
                [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
            ] 
        end
        
        it "returns a matrix for the seatplan" do
            expect(subject).to eq(result)
        end
    end

    describe "#verify_seats" do
        subject { described_class.new(seats, passengers).verify_seats }
        let(:result) { [true, "Success"] }
        
        it "returns true" do
            expect(subject).to eq(result)
        end
    end

    describe "#add_passengers" do
        let(:max_rows) { 4 }
        let(:plane) do
            [
                [[nil, nil, nil], [nil, nil, nil]],                                                      
                [[nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, nil]],                      
                [[nil, nil], [nil, nil], [nil, nil]],                                                    
                [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
            ] 
        end
        let(:plane_layout) do
            [
                [
                    [["W"], ["M"], ["A"]], [["W"], ["M"], ["A"]]
                ],
                [
                    [["A"], ["M"], ["M"], ["A"]], 
                    [["A"], ["M"], ["M"], ["A"]], 
                    [["A"], ["M"], ["M"], ["A"]]
                ],
                [
                    [["A"], ["A"]], 
                    [["A"], ["A"]], 
                    [["A"], ["A"]]
                ],
                [
                    [["A"], ["M"], ["W"]], 
                    [["A"], ["M"], ["W"]], 
                    [["A"], ["M"], ["W"]], 
                    [["A"], ["M"], ["W"]]
                ]
            ]
        end
        subject { described_class.new(seats, passengers).add_passengers(plane_layout, plane, max_rows) }
        let(:result) do
            [
                [
                    [["W", 19], ["M", 25], ["A", 1]], 
                    [["W", 21], ["M", 29], ["A", 7]]
                ],
                [
                    [["A", 2], ["M", 26], ["M", 27], ["A", 3]], 
                    [["A", 8], ["M", 30], ["M", nil], ["A", 9]], 
                    [["A", 13], ["M", nil], ["M", nil], ["A", 14]]
                ],
                [
                    [["A", 4], ["A", 5]],
                    [["A", 10], ["A", 11]],
                    [["A", 15], ["A", 16]]
                ],
                [
                    [["A", 6], ["M", 28], ["W", 20]], 
                    [["A", 12], ["M", nil], ["W", 22]], 
                    [["A", 17], ["M", nil], ["W", 23]], 
                    [["A", 18], ["M", nil], ["W", 24]]
                ]
            ]
        end
        
        it "returns a matrix for the seatplan" do
            expect(subject).to eq(result)
        end
    end
end