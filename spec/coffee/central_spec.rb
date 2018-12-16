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
    expect(result.print_method).to eq("3 (1.0, 2.0) \n")
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

  it "should return file input" do
    input = Coffee::Central.get_town_file_input('/sample_data/success/input1.txt')
    expect(input.first).to eq("4 4 5 3\n1 1\n1 2\n3 3\n4 4\n2 4\n1\n2\n4\n3 3 3 1\n1 1\n1 2\n1 3\n1\n0 0 0 0")
  end

  it "should raise error not exist file" do
    expect {
      Coffee::Central.get_town_file_input('/sample_data/not_exist.txt')
    }.to raise_error(Errno::ENOENT)
  end

  it "result success for input1" do
    result = Coffee::Central.get_result(Coffee::Central.get_town_file_input('/sample_data/success/input1.txt'))

    expect(result.first).to eq("3 (3, 4) \n4 (2, 2) \n5 (3, 1) \n5 (3, 2) \n")
  end

  it "result success for input2" do
    result = Coffee::Central.get_result(Coffee::Central.get_town_file_input('/sample_data/success/input2.txt'))

    puts result.first
    expect(result.first).to be_a(String)
    expect(result.first).to eq("3 (3, 4) \n4 (2, 2) \n5 (3, 1) \n0 (1, 1) \n")
  end

  it "result success for input3" do
    result = Coffee::Central.get_result(Coffee::Central.get_town_file_input('/sample_data/success/input3.txt'))

    puts result.first
    expect(result.first).to be_a(String)
    expect(result.first).to eq("3 (3, 4) \n4 (2, 2) \n5 (3, 1) \n5 (3, 2) \n")
  end

  it "result fail for input1" do
    expect {
      Coffee::Central.get_result(Coffee::Central.get_town_file_input('/sample_data/fail/input1.txt'))
    }.to raise_error(StandardError, 'Invalid input data')
  end

  it "result fail for input2" do
    expect {
      Coffee::Central.get_result(Coffee::Central.get_town_file_input('/sample_data/fail/input2.txt'))
    }.to raise_error(StandardError, 'Invalid input data')
    end

  it "result fail for input3" do
    expect {
      Coffee::Central.get_result(Coffee::Central.get_town_file_input('/sample_data/fail/input3.txt'))
    }.to raise_error(StandardError, 'Invalid input data')
  end

end
