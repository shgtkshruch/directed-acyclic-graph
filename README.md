# DAG Study

A study on implementing [DAG](https://ja.wikipedia.org/wiki/%E6%9C%89%E5%90%91%E9%9D%9E%E5%B7%A1%E5%9B%9E%E3%82%B0%E3%83%A9%E3%83%95) in Ruby.  

## Install

- [Graphviz](https://graphviz.org/)

```sh
brew install graphviz
bundle install
```

Run test

```rb
ruby test/
```

Generate graph image

```sh
bundle exec ruby rgl.rb
```

## Reference URL
- [module TSort (Ruby 2.7.0 リファレンスマニュアル)](https://docs.ruby-lang.org/ja/latest/class/TSort.html)
- [graphlib — Functionality to operate with graph-like structures — Python 3.9.0 documentation](https://docs.python.org/3.9/library/graphlib.html#graphlib.TopologicalSorter)
