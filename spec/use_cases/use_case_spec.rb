RSpec.describe UseCase do
  class DummyUseCase
    include UseCase
  end

  describe '.perform' do
    it 'instantiates the use case and calls perform' do
      instance = double('DummyUseCase')

      expect(DummyUseCase).to receive(:new).and_return(instance)
      expect(instance).to receive(:perform)

      DummyUseCase.perform
    end
  end

  describe '#perform' do
    it 'raises NotImplementedError' do
      use_case = DummyUseCase.new

      expect { use_case.perform }.to raise_error(NotImplementedError)
    end
  end
end
