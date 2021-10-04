# Hoddarla 專案：鐵人賽第二十六天

## 實驗步驟

執行之後，會看到三個執行緒依據計時器中斷的生命週期切換，然後印出 `Hello World` 結束。

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
