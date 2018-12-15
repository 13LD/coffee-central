RSpec.describe Coffee::Central do
  it "has a version number" do
    expect(Coffee::Central::VERSION).not_to be nil
  end

  it "result class print vars" do
    result = Coffee::Central::Result.new(
      x: 1.0,
      y: 2.0,
      max_coffee_shops_amount: 3
    )
    expect(result.print).to eq("3 (1.0, 2.0)")
  end

  it "result equal method should return true" do
    result1 = Coffee::Central::Result.new(
      x: 1.0,
      y: 2.0,
      max_coffee_shops_amount: 3,
    )
    result2 = Coffee::Central::Result.new(
      x: 1.0,
      y: 2.0,
      max_coffee_shops_amount: 3,
    )
    expect(result1.equal?(result2)).to be_truthy
  end

  it "result equal method should return false" do
    result1 = Coffee::Central::Result.new(
      x: 1.0,
      y: 2.0,
      max_coffee_shops_amount: 3,
    )
    result2 = {}
    result3 = Coffee::Central::Result.new(
      x: 1.0,
      y: 2.0,
      max_coffee_shops_amount: 1,
    )
    expect(result1.equal?(result2)).to be_falsy
    expect(result1.equal?(result3)).to be_falsy
  end
end
