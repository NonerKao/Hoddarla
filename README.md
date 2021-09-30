# Hoddarla 專案：鐵人賽第二十二天

## 實驗步驟

> 今天進入新章，所以更新了 `GOBASE` 的基底。功能上沒有改動。

執行之後，一直刷出 `i = n` 的訊息，且間有時間差距。
之後可以使用 `Ctrl+A` `X` 中止 QEMU。（可以調整 QEMU 參數控制不同的記憶體大小）

也可以透過 `make EXTRA_FLAGS='-S -s'` 來將除錯埠設定在本機的 1234。
由於虛擬記憶體已經開啟，建議使用搭配的 `make debug` 來除錯。

### 從舊的 repo 繼續實驗

```
# in Hoddarla directory
git pull origin ithome
make stamps/go-env    # 今天需要重定基底，所以重編工具鏈
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
