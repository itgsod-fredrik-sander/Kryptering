require 'rspec'
require_relative '../lib/encryption'

describe 'encryption' do

  before do
    @cleartext = 'the quick brown fox jumps over the lazy dog'
    @offset = 3
  end

  it 'should take a string and an offset as arguments' do
    expect { encrypt() }.to raise_error ArgumentError
    expect { encrypt(@cleartext) }.to raise_error ArgumentError
  end

  # Detta test kan kommenteras bort om man inte vill testa 'Undantagshantering' på C eller A-nivå
  it 'should raise ArgumentError with correct error message if called with empty string' do
    expect { encrypt('', 3)}.to raise_error ArgumentError, 'String must not be empty'
  end

  # Detta test kan kommenteras bort om man inte vill testa 'Undantagshantering' på C eller A-nivå
  it 'should raise ArgumentError with correct error message if called with an offset of 0' do
    expect { encrypt(@cleartext, 0)}.to raise_error ArgumentError, 'Offset must not be zero'
  end

  it 'should return a string' do
    expect(encrypt(@cleartext, @offset)).to be_a String
  end

  it 'should return the encrypted string capitalized' do
    encrypt(@cleartext, 3).should match 'WKH TXLFN EURZQ IRA MXPSV RYHU WKH ODCB GRJ'
    encrypt(@cleartext, 13).should match 'GUR DHVPX OEBJA SBK WHZCF BIRE GUR YNML QBT'
    encrypt(@cleartext, 5).should match 'YMJ VZNHP GWTBS KTC OZRUX TAJW YMJ QFED ITL'
  end

  it 'should accept negative offsets' do
     encrypt(@cleartext, -2).should match 'RFC OSGAI ZPMUL DMV HSKNQ MTCP RFC JYXW BME'
    encrypt(@cleartext, -11).should match 'IWT FJXRZ QGDLC UDM YJBEH DKTG IWT APON SDV'
    encrypt(@cleartext, -4).should match 'PDA MQEYG XNKSJ BKT FQILO KRAN PDA HWVU ZKC'
  end

  it 'should accept lower- as well ass upper-case letters' do
    encrypt('The quiCk broWn fox JUMPS over the lazY dog', 3).should match 'WKH TXLFN EURZQ IRA MXPSV RYHU WKH ODCB GRJ'
  end

end
