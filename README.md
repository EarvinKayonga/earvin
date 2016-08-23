# Earvin

**Hosted at**
[earvinkayonga.com](http://earvinkayonga.com)

Status :
[![Stories in Ready](https://badge.waffle.io/EarvinKayonga/earvin.svg?label=ready&title=Ready)](http://waffle.io/EarvinKayonga/earvin)

## Installation

On linux based OS,
** Make sure to have the latest version of ruby-dev and gem:**
```
sudo apt-get install build-essential ruby-dev
gem sources --add https://rubygems.org/
gem update --no-rdoc --no-ri --system
gem install pygments.rb jekyll jekyll-paginate rdiscount # Dependency of Sustain
```

See the result on port 3000
```
cd blog;
jekyll s --watch
```

Build the static files

```
cd blog;
jekyll build
```
