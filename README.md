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
group :development do
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

![image](https://i.loli.net/2018/03/31/5abef9ddcd9ad.png)

```
git checkout -b gems
---
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
group :development do
---
gem 'better_errors', '~> 2.4'
gem 'guard', '~> 2.14', '>= 2.14.1'
gem 'guard-livereload', '~> 2.5', '>= 2.5.2', require: false
```
```
bundle install
guard init livereload
bundle exec guard
exit
rails generate simple_form:install
```
```
app/assets/stylesheets/application.scss
---
@import "bulma";
```

```
# git checkout -b home
rails g controller home index
---
root 'home#index'
rails server
app/views/home/index.html.erb
---
<h1>欢迎来到才华横溢的世界</h1>
```
![image](https://i.loli.net/2018/03/31/5abf02a902118.png)

```
# git checkout -b navbar
---
app/views/layouts/application.html.erb
---
<!DOCTYPE html>
<html>
  <head>
    <title>DribbbleClone</title>
    <%= csrf_meta_tags %>
 		<meta name="viewport" content="width=device-width, initial-scale=1">
    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= stylesheet_link_tag "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
  	<% if flash[:notice] %>
    	<div class="notification is-primary global-notification">
  	  	<p class="notice"><%= notice %></p>
    	</div>
   	<% end %>
    <% if flash[:alert] %>
    <div class="notification is-danger global-notification">
      <p class="alert"><%= alert %></p>
    </div>
    <% end %>
     <nav class="navbar is-dark" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <%= link_to root_path, class:"navbar-item" do %>
          <h1 class="title is-5 has-text-white">Dribbble Clone</h1>
     <% end %>
     </nav>

<%= yield %>
 </body>
</html>
```

```
# git checkout -b devise
rails g devise:install
rails g devise:views
rails g devise User
rake db:migrate

config/routes.rb
---
Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'home#index'
end
---
app/controllers/registrations_controller.rb
---
class RegistrationsController < Devise::RegistrationsController

 private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end

end
```
```
rails g migration AddFieldsToUsers name:string
rake db:migrate
rails server
http://localhost:3000/users/sign_up
```
![image](https://i.loli.net/2018/03/31/5abf0644ec6a1.png)
```
app/views/devise/sessions/new.html.erb
---
<h2>Log in</h2>

<%= simple_form_for(resource, as: resource_name, url: session_path(resource_name)) do |f| %>
  <div class="form-inputs">
    <%= f.input :email, required: false, autofocus: true %>
    <%= f.input :password, required: false %>
    <%= f.input :remember_me, as: :boolean if devise_mapping.rememberable? %>
  </div>

  <div class="form-actions">
    <%= f.button :submit, "Log in" %>
  </div>
<% end %>

<%= render "devise/shared/links" %>
---
app/views/devise/registrations/new.html.erb
---
<h2>Sign up</h2>

<%= simple_form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :email, required: true, autofocus: true %>
    <%= f.input :password, required: true, hint: ("#{@minimum_password_length} characters minimum" if @minimum_password_length) %>
    <%= f.input :password_confirmation, required: true %>
  </div>

  <div class="form-actions">
    <%= f.button :submit, "Sign up" %>
  </div>
<% end %>

<%= render "devise/shared/links" %>
---
<section class="section">
  <div class="container">
    <div class="columns is-centered">
      <div class="column is-4">
				<h2 class="title is-2">Sign up</h2>

				<%= simple_form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
				  <%= f.error_notification %>


				<div class="field">
				  	<div class="control">
				    	<%= f.input :name, required: true, autofocus: true, input_html: { class: "input"}, wrapper: false, label_html: { class: "label" } %>
				    </div>
				  </div>


          <div class="field">
            <div class="control">
				    <%= f.input :email, required: true, input_html: { class: "input"}, wrapper: false, label_html: { class: "label" } %>
				  	</div>
					</div>

          <div class="field">
            <div class="control">
				    <%= f.input :password, required: true, input_html: { class: "input"}, wrapper: false, label_html: { class: "label" }, hint: ("#{@minimum_password_length} characters minimum" if @minimum_password_length) %>
				  	</div>
					</div>

          <div class="field">
            <div class="control">
				    <%= f.input :password_confirmation, required: true, input_html: { class: "input"}, wrapper: false, label_html: { class: "label" } %>
				  	</div>
					</div>

				<%= f.button :submit, "Sign up", class:"button is-primary is-medium" %>

				<% end %>
				<br />
				<%= render "devise/shared/links" %>
			</div>
		</div>
	</div>
</section>
---
app/views/devise/registrations/edit.html.erb
---
<h2>Edit <%= resource_name.to_s.humanize %></h2>

<%= simple_form_for(resource, as: resource_name, url: registration_path(resource_name), html: { method: :put }) do |f| %>
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :email, required: true, autofocus: true %>

    <% if devise_mapping.confirmable? && resource.pending_reconfirmation? %>
      <p>Currently waiting confirmation for: <%= resource.unconfirmed_email %></p>
    <% end %>

    <%= f.input :password, autocomplete: "off", hint: "leave it blank if you don't want to change it", required: false %>
    <%= f.input :password_confirmation, required: false %>
    <%= f.input :current_password, hint: "we need your current password to confirm your changes", required: true %>
  </div>

  <div class="form-actions">
    <%= f.button :submit, "Update" %>
  </div>
<% end %>

<h3>Cancel my account</h3>

<p>Unhappy? <%= link_to "Cancel my account", registration_path(resource_name), data: { confirm: "Are you sure?" }, method: :delete %></p>

<%= link_to "Back", :back %>
---
<section class="section">
  <div class="container">
    <div class="columns is-centered">
      <div class="column is-4">

      <h2 class="title is-2">Edit <%= resource_name.to_s.humanize %></h2>
      <%= simple_form_for(resource, as: resource_name, url: registration_path(resource_name), html: { method: :put }) do |f| %>
        <%= f.error_notification %>

          <div class="field">
            <div class="control">
              <%= f.input :name, required: true, autofocus: true, input_html: { class: "input"}, wrapper: false, label_html: { class: "label" } %>
            </div>
          </div>

          <div class="field">
            <div class="control">
              <%= f.input :email, required: true, input_html: { class: "input"}, wrapper: false, label_html: { class: "label" } %>
            </div>
          </div>

          <div class="field">
          <% if devise_mapping.confirmable? && resource.pending_reconfirmation? %>
            <p>Currently waiting confirmation for: <%= resource.unconfirmed_email %></p>
          <% end %>
          </div>

          <div class="field">
            <div class="control">
            <%= f.input :password, autocomplete: "off", hint: "leave it blank if you don't want to change it", required: false, input_html: { class: "input"}, wrapper: false, label_html: { class: "label" } %>
            </div>
          </div>

          <div class="field">
            <div class="control">
            <%= f.input :password_confirmation, required: false, input_html: { class: "input"}, wrapper: false, label_html: { class: "label" } %>
            </div>
          </div>

          <div class="field">
            <div class="control">
              <%= f.input :current_password, hint: "we need your current password to confirm your changes", required: true, input_html: { class: "input"}, wrapper: false, label_html: { class: "label" } %>
            </div>
        </div>

        <%= f.button :submit, "Update", class:"button is-primary" %>

      <% end %>

        <hr />
        <h3 class="title is-5">Cancel my account</h3>
        <p>Unhappy? <%= link_to "Cancel my account", registration_path(resource_name), data: { confirm: "Are you sure?" }, method: :delete %></p>

      </div>
    </div>
  </div>
</section>
```
![image](https://i.loli.net/2018/03/31/5abf102b12f82.png)
![image](https://i.loli.net/2018/03/31/5abf10184ab8a.png)
```
# git checkout -b scaffold-shot
rails g scaffold Shot title:string description:text user_id:integer
rake db:migrate
---
app/models/shot.rb
---
class Shot < ApplicationRecord
  belongs_to :user
end
---
app/models/user.rb
---
has_many :shots, dependent: :destroy
---
config/routes.rb
root 'shots#index'
```
![image](https://i.loli.net/2018/03/31/5abf0a2403465.png)

```
app/views/shots/index.html.erb
---


<h1>Shots</h1>

<table>
  <thead>
    <tr>
      <th>Title</th>
      <th>Description</th>
      <th>User</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @shots.each do |shot| %>
      <tr>
        <td><%= shot.title %></td>
        <td><%= shot.description %></td>
        <td><%= shot.user_id %></td>
        <td><%= link_to 'Show', shot %></td>
        <td><%= link_to 'Edit', edit_shot_path(shot) %></td>
        <td><%= link_to 'Destroy', shot, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>
---
app/views/shots/show.html.erb
---
<p>
  <strong>Title:</strong>
  <%= @shot.title %>
</p>

<p>
  <strong>Description:</strong>
  <%= @shot.description %>
</p>


<%= link_to 'Edit', edit_shot_path(@shot) %> |
<%= link_to 'Back', shots_path %>
---
app/views/shots/_shot.json.jbuilder
---
json.extract! shot, :id, :title, :description, :created_at, :updated_at
json.url shot_url(shot, format: :json)
---
app/views/shots/_form.html.erb
---
<%= simple_form_for(@shot) do |f| %>
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :title %>
    <%= f.input :description %>
  </div>

  <div class="form-actions">
    <%= f.button :submit %>
  </div>
<% end %>
---
<!DOCTYPE html>
<html>
  <head>
    <title>DribbbleClone</title>
    <%= csrf_meta_tags %>
 		<meta name="viewport" content="width=device-width, initial-scale=1">
    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= stylesheet_link_tag "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
  	<% if flash[:notice] %>
    	<div class="notification is-primary global-notification">
  	  	<p class="notice"><%= notice %></p>
    	</div>
   	<% end %>
    <% if flash[:alert] %>
    <div class="notification is-danger global-notification">
      <p class="alert"><%= alert %></p>
    </div>
    <% end %>
     <nav class="navbar is-dark" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <%= link_to root_path, class:"navbar-item" do %>
          <h1 class="title is-5 has-text-white">Dribbble Clone</h1>
        <% end  %>
      <div class="navbar-burger burger" data-target="navbar">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div>

      <div id="navbar" class="navbar-menu">

        <div class="navbar-start">
          <div class="navbar-item">
            <div class="field is-grouped">
              <p class="control">
                <%= link_to 'Shots', root_path , class:"button is-dark" %>
              </p>
            </div>
          </div>
        </div>

        <div class="navbar-end">
          <div class="navbar-item">
            <div class="field is-grouped">
              <% if user_signed_in? %>
              <p class="control">
                <%= link_to new_shot_path, class:"button is-primary"  do %>
                  <span class="icon is-small"><i class="fa fa-upload"></i></span>
                  <span>New Shot</span>
                <% end %>
              </p>
              <p class="control">
                <%= link_to current_user.name, edit_user_registration_path, class:"button is-dark" %>
              </p>
              <p class="control">
                <%= link_to "Log Out", destroy_user_session_path, method: :delete, class:"button is-dark" %>
              </p>
              <% else %>
              <p class="control">
                 <%= link_to "Sign In", new_user_session_path, class:"button is-dark" %>
              </p>
              <p class="control">
                <%= link_to "Sign up", new_user_registration_path, class:"button is-dark"%>
              </p>
              <% end %>
            </div>
          </div>
        </div>
      </div>
    </nav>

    <%= yield %>
  </body>
</html>
---
app/assets/stylesheets/application.scss
---
$pink: #ea4c89;
$pink-invert: #fff;

$primary: $pink;
$primary-invert: $pink-invert;
$link: $primary;
$link-hover: darken($primary, 20%);


@import "bulma";

html, body {
 min-height: 100vh;
 background-color: #f4f4f4;
}

#drop_zone {
 position: relative;
 padding: 3rem 0;
 border: 2px dashed #ccc;
 text-align: center;
 border-radius: 6px;
 background-color: #f8f8f8;
 &.dragging::before {
   content: "";
   position: absolute;
   left: 0; width: 100%;
   top: 0; height: 100%;
   display: flex;
   justify-content: center;
   align-items: center;
   font-size: 1.5em;
   background-color: rgba($primary, .3);
   pointer-events: none;
   z-index: 99;
 }
 &.fire::before {
   content: "";
   position: absolute;
   left: 0; width: 100%;
   top: 0; height: 100%;
   display: flex;
   justify-content: center;
   align-items: center;
   font-size: 1.5em;
   background-color: rgba($green, .3);
   pointer-events: none;
   z-index: 99;
 }
}

.notification {
 border-radius: none;
}
.notification:not(:last-child) {
 margin-bottom: 0;
}

.visible {
 display: block !important;
}
```
![image](https://i.loli.net/2018/03/31/5abf0e98118bb.png)
![image](https://i.loli.net/2018/03/31/5abf0e883117f.png)

```
# 用户名称的对应
rails c
2.3.1 :001 > @user = User
2.3.1 :002 > User.connection
2.3.1 :003 > @user = User
2.3.1 :004 > @user.last
2.3.1 :005 > @user.last
2.3.1 :006 > @user.destroy
2.3.1 :007 > @user.last
2.3.1 :009 > @user.destroy
2.3.1 :009 > @user.destroy
2.3.1 :010 > @user.destroy
2.3.1 :011 > exit
```
![image](https://i.loli.net/2018/03/31/5abf12df61f05.png)

```
git checkout -b shot-view
app/views/shots/new.html.erb
---
<h1>New Shot</h1>

<%= render 'form', shot: @shot %>

<%= link_to 'Back', shots_path %>
---
<section class="section">
	<div class="container">
		<h1 class="title is-2 has-text-centered">What are you working on?</h1>
		<%= render 'form', shot: @shot %>
	</div>
</section>
---
app/views/shots/_form.html.erb
---

<%= simple_form_for(@shot) do |f| %>
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :title %>
    <%= f.input :description %>
  </div>

  <div class="form-actions">
    <%= f.button :submit %>
  </div>
<% end %>
---
<%= simple_form_for @shot, html: { multipart: true }  do |f| %>
  <%= f.error_notification %>
  <div class="columns is-centered">
    <div class="column is-half">

    <%#unless @shot.user_shot.blank? %>
    <%#= image_tag (@shot.user_shot_url), id: "previewImage" %>
    <%# end %>

    <output id="list"></output>
    <div id="drop_zone">Drag your shot here</div>
    <br />

    <%#= f.input :user_shot, label: false, input_html: { class: "file-input", type: "file" }, wrapper: false, label_html: { class: "file-label" } %>

    <div class="field">
      <div class="control">
      	<%= f.input :title, label: "Title", input_html: { class: "input"}, wrapper: false, label_html: { class: "label" } %>
      </div>
    </div>

    <div class="field">
    	<div class="control">
      	<%= f.input :description, input_html: { class: "textarea"}, wrapper: false, label_html: { class: "label" } %>
      </div>
    </div>

    <div class="field">
    	<div class="control">
      	<%= f.button :submit, class:"button is-primary" %>
      </div>
    </div>
  </div>
</div>


<% end %>
---
```
![image](https://i.loli.net/2018/03/31/5abf2013acf89.png)

```
rails g uploader Shot
rails g uplooader user_shot
rails g uploader user_shot
rails g migration add_user_shot_to_shots
rake db:migrate
```
![image](https://i.loli.net/2018/03/31/5abf22cd1df24.png)
```
app/uploaders/shot_uploader.rb
---
class ShotUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
   include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  ---
  app/uploaders/user_shot_uploader.rb
  ---
  class UserShotUploader < CarrierWave::Uploader::Base
    # Include RMagick or MiniMagick support:
    # include CarrierWave::RMagick
     include CarrierWave::MiniMagick

    # Choose what kind of storage to use for this uploader:
    storage :file
    # storage :fog

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    # Provide a default URL as a default if there hasn't been a file uploaded:
    # def default_url(*args)
    #   # For Rails 3.1+ asset pipeline compatibility:
    #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    #
    #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    # end

    # Process files as they are uploaded:
    # process scale: [200, 300]
    #
    # def scale(width, height)
    #   # do something
    # end

    # Create different versions of your uploaded files:
     version :full do
       process resize_to_fit: [800, 600]
     end

     version :thumb do
       process resize_to_fit: [400, 300]
     end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
     def extension_whitelist
       %w(jpg jpeg gif png)
     end

    # Override the filename of the uploaded files:
    # Avoid using model.id or version_name here, see uploader/store.rb for details.
    # def filename
    #   "something.jpg" if original_filename
    # end
  end
  ---
  db/migrate/20180331055004_add_user_shot_to_shots.rb
  ---
  class AddUserShotToShots < ActiveRecord::Migration[5.1]
    def change
      add_column :shots, :user_shot, :string
    end
  end
  ---
app/models/shot.rb
---
class Shot < ApplicationRecord
  belongs_to :user
  mount_uploader :user_shot, UserShotUploader
end
---
app/views/shots/_form.html.erb
---
<output id="list"></output>
<div id="drop_zone">Drag your shot here</div>
<br />

<%= f.input :user_shot, label: false, input_html: { class: "", type: "file" }, wrapper: false, label_html: { class: "file-label" } %>
---
```
![image](https://i.loli.net/2018/03/31/5abf2578b31d2.png)
```
app/assets/javascripts/shots.js
---
document.addEventListener("turbolinks:load", function() {

	var Shots = {
		previewShot() {
			if (window.File && window.FileList && window.FileReader) {

				function handleFileSelect(evt) {
					evt.stopPropagation();
					evt.preventDefault();

					let files = evt.target.files || evt.dataTransfer.files;
					// files is a FileList of File objects. List some properties.
					for (var i = 0, f; f = files[i]; i++) {

						// Only process image files.
						if (!f.type.match('image.*')) {
							continue;
						}
						const reader = new FileReader();

						// Closure to capture the file information.
						reader.onload = (function(theFile) {
							return function(e) {
								// Render thumbnail.
								let span = document.createElement('span');
								span.innerHTML = ['<img class="thumb" src="', e.target.result,
									'" title="', escape(theFile.name), '"/>'
								].join('');
								document.getElementById('list').insertBefore(span, null);
							};
						})(f);

						// Read in the image file as a data URL.
						reader.readAsDataURL(f);
					}
				}

				function handleDragOver(evt) {
					evt.stopPropagation();
					evt.preventDefault();
					evt.dataTransfer.dropEffect = 'copy'; // Explicitly show this is a copy.
				}

				// Setup the dnd listeners.
				// https://stackoverflow.com/questions/47515232/how-to-set-file-input-value-when-dropping-file-on-page
				const dropZone = document.getElementById('drop_zone');
				const target = document.documentElement;
				const fileInput = document.getElementById('shot_user_shot');
				const previewImage = document.getElementById('previewImage');
				const newShotForm = document.getElementById('new_shot');


				if (dropZone) {
					dropZone.addEventListener('dragover', handleDragOver, false);
					dropZone.addEventListener('drop', handleFileSelect, false);

					// Drop zone classes itself
					dropZone.addEventListener('dragover', (e) => {
						dropZone.classList.add('fire');
					}, false);

					dropZone.addEventListener('dragleave', (e) => {
						dropZone.classList.remove('fire');
					}, false);

					dropZone.addEventListener('drop', (e) => {
						e.preventDefault();
						dropZone.classList.remove('fire');
						fileInput.files = e.dataTransfer.files;
						// if on shot/id/edit hide preview image on drop
						if (previewImage) {
							previewImage.style.display = 'none';
						}
						// If on shots/new hide dropzone on drop
						if(newShotForm) {
							dropZone.style.display = 'none';
						}
					}, false);

					// Body specific
					target.addEventListener('dragover', (e) => {
						e.preventDefault();
						dropZone.classList.add('dragging');
					}, false);

					// removes dragging class to body WHEN NOT dragging
					target.addEventListener('dragleave', (e) => {
						dropZone.classList.remove('dragging');
						dropZone.classList.remove('fire');
					}, false);
				}
			}
		},
		shotHover() {
			$('.shot').hover(function() {
				$(this).children('.shot-data').toggleClass('visible');
			});
		}

	};
	Shots.previewShot();
	Shots.shotHover();


});
---
```
# 实现突破的拖拽上传功能
```
git add .
git commit -m "add image Drag"
