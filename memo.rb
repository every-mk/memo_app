require "csv"

ASCII_CODE_NUL = 0x00
ASCII_CODE_LF  = 0x0A

puts "1(新規でメモを作成) 2(既存のメモ編集する)"

memo_type = gets.chomp.to_s

case memo_type
when "1"
  exec_type = "w"
when "2"
  exec_type = "a"
else
  return
end

puts "拡張子を除いたファイルを入力してください"
file_name = gets.to_s + ".csv"

p "メモしたい内容を記入してください"
p "完了したらCtrl + Dをおします"

begin
  CSV.open(file_name, exec_type) do |csv|
    loop{
      line = gets.to_s
      
      # データが存在しない場合は終了する.
      if (line.slice(-1) == nil) || (line.slice(-1).ord == ASCII_CODE_NUL)
        break
      end
      
      # 1行をCSVへ追記する.
      csv << [line.chomp]
      
      # 末尾に改行がない場合は終了する.
      if line.slice(-1).ord != ASCII_CODE_LF
        break
      end
    }
  end
rescue
  puts "例外が発生しました."
  puts $! # 例外オブジェクトを出力する.
  puts $@ # 例外が発生した位置情報を出力する.
end
