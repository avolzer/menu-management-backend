# README

Requires ruby 3.3.0

### Install gems
```
bundle install
```
### Set up databases
```
rails db:setup
```
### Start server
```
rails s
```
### Run tests
```
rspec spec
```
### Convert data from json file to application model
```
curl --form "file=@filename.json" http://localhost:3000/imports
```
An example restaurant_data.json file is found in spec/fixtures/files 

The resulting Restaurant, Menu, MenuItem, and Price objects can be inspected via the rails console. 
