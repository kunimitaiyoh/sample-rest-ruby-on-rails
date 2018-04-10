<%= form_for :session, url: login_path |f| %>
  <%= f.text_field :mail %>
  <%= f.password_field :password %>
  
  <%= f.submit %>
<%= end %>