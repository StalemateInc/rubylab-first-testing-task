$LOAD_PATH.unshift(File.expand_path('../../lib', __dir__))

require 'spec_helper'
require 'binary_tree'

RSpec.describe BinarySearchTree do

  let(:test_array) { Array.new([93, 74, 60, 49, 56, 7, 86, 93, 64, 21]) }
  let(:tree) { BinarySearchTree.new(test_array) }

  describe '#initialize' do
    context 'when given an array' do
      it 'should create a BinarySearchTree instance and initialize it with values from array' do
        expect(tree.values).to eq(test_array.uniq)
      end
      it 'should create a BinarySearchTree instance without duplicated values if any present' do
        duplicates = [94, 94, 74, 60, 74, 81, 90, 74, 60, 22]
        expect(BinarySearchTree.new(duplicates).values).to eq([94, 74, 60, 81, 90, 22])
      end
      it 'should have the first array element as value in a root node' do
        expect(tree.root.val).to eq(test_array.uniq[0])
      end
      it 'should raise ArgumentError if an array is empty' do
        expect { BinarySearchTree.new([]) }.to raise_error(ArgumentError)
      end
    end
    context 'when given a single value' do
      let(:tree) { BinarySearchTree.new(3) }
      it 'should create a BinarySearch instance and initialize it with given value' do
        expect(tree.values).to eq([3])
      end
      it 'should have the given element as value in a root node' do
        expect(tree.root.val).to eq(3)
      end
    end
  end

  describe '#insert' do
    context 'when given a positive/negative/zero integer/float value' do
      it 'should correctly push positive integer value to the tree' do
        tree.insert(70)
        expect(tree.find(70)).to eq('93->74->60->64->70')
      end
      it 'should correctly push positive float value to the tree' do
        tree.insert(52.3)
        expect(tree.find(52.3)).to eq('93->74->60->49->56->52.3')
      end
      it 'should correctly push negative integer value to the tree' do
        tree.insert(-12)
        expect(tree.find(-12)).to eq('93->74->60->49->7->-12')
      end
      it 'should correctly push negative float value to the tree' do
        tree.insert(-0.12)
        expect(tree.find(-0.12)).to eq('93->74->60->49->7->-0.12')
      end
      it 'should correctly push zero value to the tree' do
        tree.insert(0)
        expect(tree.find(0)).to eq('93->74->60->49->7->0')
      end
    end
  end

  describe '#binary_tree_paths' do
    context 'when called on a valid BinarySearchTree instance' do
      it 'should return an array with all the paths to leafs' do
        expect(tree.binary_tree_paths).to eq(%w[93->74->60->49->7->21 93->74->60->49->56 93->74->60->64 93->74->86])
      end
    end
  end

  describe '#find' do
    context 'when called with absent element' do
      it 'should return nil' do
        expect(tree.find(70)).to eq(nil)
      end
    end
    context 'when called with the present element' do
      it 'should return string with path to element' do
        tree.insert(70)
        expect(tree.find(70)).to eq('93->74->60->64->70')
      end
    end
  end
end