# Hoddarla 專案：鐵人賽第十天

## 實驗步驟

這個版本會在虛擬記憶體啟動後，跑出 `HI` 字樣以及隨後而來的三組狀態暫存器的顯示，且第一次看到 `scause=0xc`
之後可以使用 `Ctrl+A` `X` 中止 QEMU。

也可以透過 `make EXTRA_FLAGS='-S -s'` 來將除錯埠設定在本機的 1234。

### 從舊的 repo 繼續實驗

```
# in Hoddarla directory
git pull origin ithome
make apply         # 引用新的 patch；跟各位讀者抱歉，先前幾天沒有更新到
make stamps/go-dev # 若是因為筆者的 Makefile 相依性太粗糙無法驅動，請使用
                   # cd go/src && ./make.bash 重編工具鏈
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
