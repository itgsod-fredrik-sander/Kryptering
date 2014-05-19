require 'rspec'
require_relative '../lib/encryption'

describe 'decryption' do

  before do
    @cleartext = 'the quick brown fox jumps over the lazy dog'
    @offset = 3
  end

  it 'should take a string and an offset as arguments' do
    expect { decrypt()}.to raise_error ArgumentError
  end

  # Detta test kan kommenteras bort om man inte vill testa 'Undantagshantering' på C eller A-nivå
  it 'should raise ArgumentError with correct error message if called with empty string' do
    expect { decrypt('', 3)}.to raise_error ArgumentError, 'String must not be empty'
  end

  # Detta test kan kommenteras bort om man inte vill testa 'Undantagshantering' på C eller A-nivå
  it 'should raise ArgumentError with correct error message if called with an offset of 0' do
    expect { decrypt(@cleartext, 0)}.to raise_error ArgumentError, 'Offset must not be zero'
  end

  it 'should return a string' do
    expect(decrypt(@cleartext, @offset)).to be_a String
  end

  it 'should return the encrypted string in lower-case' do
    decrypt('WKH TXLFN EURZQ IRA MXPSV RYHU WKH ODCB GRJ', 3).should match @cleartext
    decrypt('GUR DHVPX OEBJA SBK WHZCF BIRE GUR YNML QBT', 13).should match @cleartext
    decrypt('YMJ VZNHP GWTBS KTC OZRUX TAJW YMJ QFED ITL', 5).should match @cleartext
  end

  it 'should accept negative offsets' do
    decrypt('RFC OSGAI ZPMUL DMV HSKNQ MTCP RFC JYXW BME', -2).should match @cleartext
    decrypt('IWT FJXRZ QGDLC UDM YJBEH DKTG IWT APON SDV', -11).should match @cleartext
    decrypt('PDA MQEYG XNKSJ BKT FQILO KRAN PDA HWVU ZKC', -4).should match @cleartext
  end
end