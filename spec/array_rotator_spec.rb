$LOAD_PATH.unshift(File.expand_path('../../lib', __dir__))

require 'spec_helper'
require 'array_rotator'

RSpec.describe ArrayRotator do
  let(:array) { Array.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }
  let(:rotator) { ArrayRotator.new(array) }
  describe '#rotate' do
     context 'when given a correct k value' do
       it 'should rotate the given array to k (k < array.length) positions to the right' do
         expect(rotator.rotate(4)).to eq([6, 7, 8, 9, 1, 2, 3, 4, 5])
       end

       it 'should rotate the given array to k (k >= array.length) positions to the right' do
         expect(rotator.rotate(10)).to eq([9, 1, 2, 3, 4, 5, 6, 7, 8])
       end
     end

     context 'when given an incorrect k value' do
       it 'should raise an ArgumentError if k == 0' do
         expect { rotator.rotate(0) }.to raise_error(ArgumentError)
       end

       it 'should raise an ArgumentError if k < 0' do
         expect { rotator.rotate(-5) }.to raise_error(ArgumentError)
       end
     end

     context 'when used on ArrayRotator instance with an empty array' do
       it 'should return the same empty array' do
         rotator.array = []
         expect(rotator.rotate(5)).to eq([])
       end
     end

     context 'when used on the same ArrayRotator with another array (reused instance of ArrayRotator)' do
       it 'should return the correct result' do
         rotator.rotate(4)
         another_array = [6, 3, 4, 5]
         rotator.array = another_array
         another_rotator = ArrayRotator.new(another_array)
         expect(rotator.rotate(3)).to eq(another_rotator.rotate(3))
       end
     end
   end
end
