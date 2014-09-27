require 'ruby-fann'

class Predict
  def self.predict
    data = BrightnessData.all
    train = RubyFann::TrainData.new(
      inputs: data.map(&:to_training_inputs),
      desired_outputs: data.map(&:to_training_outputs)
    )
    fann = RubyFann::Standard.new(:num_inputs=>5, :hidden_neurons=>[2, 8, 4, 3, 4], :num_outputs=>3)
    fann.train_on_data(train, 1000, 10, 0.1) # 1000 max_epochs, 10 errors between reports and 0.1 desired MSE (mean-squared-error)
    outputs = fann.run([4000, 1, 500, 1350, 1000])
    p outputs
  end
end
