# Hoddarla 專案：鐵人賽第二十七天

## 實驗步驟

執行之後等待一下，可以看到 `hdla > ` 的命令提示字元，之後可以試試 `cheers` 與 `exit` 指令。
至此，Hoddarla 在第 13 屆鐵人賽的技術部份正式走到一個段落，感謝大家！

![](https://github.com/NonerKao/Hoddarla/blob/ithome/tty.gif)

### 從舊的 repo 繼續實驗

```
# in Hoddarla directory
git pull origin ithome
make apply
make clean && make
```

### 從頭開始

```
git clone git@github.com:NonerKao/Hoddarla.git
cd Hoddarla
make env
. .hdlarc
make opensbi
make clean && make
```
