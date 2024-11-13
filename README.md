# 實作時間
大一下 - 邏輯設計實驗
# 摘要
用verilog做出一個頻率分析系統，主要流程是先將輸入進來的訊號經過低通濾波器把高頻的雜音過濾掉，接著透過FFT將訊號從Time domain轉成Frequency domain，最後找出擁有最多的頻率。
# 功能介紹
主要分成四個部分，第一個部分是實作FIR Filter，宣告31個DFF來儲存並配合sequential電路達成data shifted，將每個DFF的data乘上助教提供的係數，已達到濾波功能。第二個部分是S2P，功能是將陸續進來的訊號變成平行發放出去。第三個部分是用ADDER跟COUNT組合處理初FFT的效果，這部分要注意數值處理的問題(signed & unsigned)，最後的部分是依序分析頻率大小，並找出最大的頻率。
![image](https://github.com/user-attachments/assets/35fdf25f-e726-4524-b16a-6acae8610c0f)
