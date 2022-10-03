# README

Simple Web Application of Upload and Watch Videos

 1. User can upload videos based on specific categories
 2. System 'll generate thumbnails automatically from the Video and store in Database
 3. User can watch the uploaded video from videos listing page
 
 

# Demo
![demo](https://user-images.githubusercontent.com/22412472/193485662-8a1a9fd8-e827-475a-a8f8-a530a6121335.gif)

# Ruby 
ruby 2.5.9

# Rails
Rails 5.2.8.1

# Build 
* bundle install
* rails db:create 
* bunlde exec rake db:migrate db:seed 

# Docker
```
docker-compose build
docker-compose up
```

# System Dependencies without Docker
```
* Linux
sudo apt update
sudo apt install ffmpeg
sudo apt install imagemagick

* macOS
brew install ffmpeg
brew install imagemagick
```
