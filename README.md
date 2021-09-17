# Hoddarla 專案：鐵人賽第八天

## 實驗步驟

今天這個版本，可以在 OpenSBI 之後跑出 `HI` 字樣，以及隨後而來的三組狀態暫存器的顯示。
之後可以使用 `Ctrl+A` `X` 中止 QEMU。

也可以透過 `make EXTRA_FLAGS='-S -s'` 來將除錯埠設定在本機的 1234。

### 從舊的 repo 繼續實驗

```
# in Hoddarla directory
git pull origin ithome
make opensbi
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
