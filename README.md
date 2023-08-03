# haskell-partials

Playing with random values. Also trying to uncover a way to deal with partial data structures. I would like to achieve something similar for Servant:

```Haskell
type API = ReqBody '[JSON] (Partial User) => Get '[JSON] User
```
