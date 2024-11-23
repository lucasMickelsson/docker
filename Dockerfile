# Use a Node.js base image
FROM node:20.17.0-alpine

# Set the working directory inside the container
WORKDIR /my-app

# Copy package files first to install dependencies (layer caching optimization)
COPY ./package*.json ./

# Add `/app/node_modules/.bin` to $PATH
ENV PATH /my-app/node_modules/.bin:$PATH

# Install dependencies
RUN npm install

# Copy all project files into the container (ensure .dockerignore excludes unnecessary files)
COPY . .

# Expose the development server port
EXPOSE 3000

# Use polling for file changes (for Docker environments)
ENV CHOKIDAR_USEPOLLING=true

# Start the React development server
CMD ["npm", "start", "--", "--host", "0.0.0.0", "--port", "3000"]
