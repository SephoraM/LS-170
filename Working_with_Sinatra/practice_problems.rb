# 1. Gemfile is a server-side filetype because it's run on the server. It's used
#    by Bundler, a dependency manager for Ruby whose job it is to make sure the
#    dependencies are installed for a Ruby program to execute properly.

# 2. Ruby files are server-side filetypes. Ruby code runs on the server while
#    it handles requests

# 3. CSS files are client-side filetypes. They are sent with the response and
#    are interpreted by the browser to style the displayed content.

# 4. JavaScript files are client-side filetypes. The browser interprets the code
#    to add behaviours to the page.

# 5. View Templates are server-side. The ruby code has to be evaluated on the server
#    before a response can be generated and sent to the client. 
