# Let's Build: A Dribbble Clone With Ruby On Rails


## 主要完成的任务的实现：
- gem 的使用

```
gem "bulma-rails", "~> 0.6.1"
gem 'devise', '~> 4.3'
gem 'carrierwave', '~> 1.2', '>= 1.2.1'
gem 'simple_form', '~> 3.5'
gem "mini_magick"
gem 'impressionist', '~> 1.6'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'gravatar_image_tag'
gem 'acts_as_votable', '~> 0.11.1'
---
gem 'better_errors', '~> 2.4'
gem 'guard', '~> 2.14', '>= 2.14.1'
gem 'guard-livereload', '~> 2.5', '>= 2.5.2', require: false
```
- 功能 的架构
```
1、博客（blog）：基本的 CRUD（增删改查） + Comment（评论） + Upvote(点赞) + View（预览）
2、推特（twitter）：导航 Nav（导航） + Devise 的使用
3、达波（dribble）：图片 Image 的使用
4、装修 SCSS 的使用
```
- 云端 的部署
```
1、heroku 的部署
2、aliyun 的部署
```

```
cd workspace
rails new dribbble_clone
cd dribbble_clone
atom .
rails s
http://localhost:3000/
---
git add .
git commit -m "initial commit"
git remote add origin https://github.com/shenzhoudance/dribbble_clone.git
git push -u origin master
```

![image](Let's Build: A Dribbble Clone With Ruby On Rails)
