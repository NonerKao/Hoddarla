# Hoddarla 專案：鐵人賽第十三天

## 實驗步驟

本日的 patch 之後，顯示 `fatalthrow` 的回溯訊息之前，可以看見記憶體起始位址與大小。
之後可以使用 `Ctrl+A` `X` 中止 QEMU。（可以調整 QEMU 參數控制不同的記憶體大小）

也可以透過 `make EXTRA_FLAGS='-S -s'` 來將除錯埠設定在本機的 1234。
由於虛擬記憶體已經開啟，建議使用搭配的 `make debug` 來除錯。

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
