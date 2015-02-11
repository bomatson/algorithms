require 'byebug'
require 'rspec'
require_relative 'percolation'

describe Percolation do
  # describe '#initialize' do
  #   subject { Percolation.new 10 }

  #   it 'sets the size to be N by N grid' do
  #     expect(subject.size).to eq 100
  #   end

  #   it 'sets the sites to be a two dimensional array' do
  #     expect(subject.sites.sample).to be_kind_of Array
  #   end
  # end

  # describe '#is_open?' do
  #   subject { Percolation.new 5 }

  #   context 'given a closed site' do
  #     it 'returns false' do
  #       expect(subject.is_open?(1,1)).to eq false
  #     end
  #   end

  #   context 'given an open site' do
  #     before do
  #       subject.sites[4][4] = 1
  #     end

  #     it 'returns true' do
  #       expect(subject.is_open?(5,5)).to eq true
  #     end
  #   end
  # end

  # describe '#open' do
  #   subject { Percolation.new 5 }

  #   context 'given no open neighbors' do
  #     it 'returns false' do
  #       subject.open(1,1)
  #       expect(subject.is_open?(1,1)).to eq true
  #     end
  #   end
  # end

  # describe '#is_full?' do
  #   subject { Percolation.new 5 }

  #   context 'given no connection to the top row' do
  #     it 'returns false' do
  #       subject.open(1,1)
  #       subject.open(3,1)
  #       expect(subject.is_full?(3,1)).to eq false
  #     end
  #   end

  #   context 'given a connection to the top row' do
  #     it 'returns true' do
  #       subject.open(1,1)
  #       subject.open(2,1)
  #       expect(subject.is_full?(2,1)).to eq true
  #     end
  #   end
  # end

  # describe '#percolates?' do
  #   subject { Percolation.new 5 }

  #   context 'given no connection to the top row' do
  #     it 'returns false' do
  #       subject.open(1,1)
  #       subject.open(2,1)
  #       subject.open(5,2)
  #       expect(subject.percolates?).to eq false
  #     end
  #   end

  #   context 'given a connection to the top row' do
  #     it 'returns true' do
  #       subject.open(1,1)
  #       subject.open(2,1)
  #       subject.open(3,1)
  #       subject.open(4,1)
  #       subject.open(5,1)
  #       expect(subject.percolates?).to eq true
  #     end
  #   end
  # end

  describe 'given large data sets' do
    let(:fixtures) {{
      'greeting57' => false,
      'heart25' => false,
      'input1-no' => false,
      'input1' => true,
      'input2-no' => false,
      'input2' => true,
      'input3' => true,
      'input4' => true,
      'input5' => true,
      'input6' => true,
      'input7' => true,
      # 'input8-no' => false,
      # 'input8' => true,
      # 'input10-no' => false,
      'input10' => true,
      'input20' => true,
      'input50' => true,
      'jerry47' => true,
      'sedgewick60' => true,
      'wayne98' => true
    }}

    it 'matches each test file' do
      fixtures.each do |fixture, value|
        File.open(File.expand_path("week_1/test_data/#{fixture}.txt"), 'r') do |f|
          num = f.readline.to_i
          experiment = Percolation.new num

          f.each_line do |line|
            formatted_line = line.split(' ')

            if formatted_line.length == 2
              experiment.open formatted_line[0].to_i, formatted_line[1].to_i
            end
          end

          expect(experiment.percolates?).to eq value
        end
      end
    end
  end
end
