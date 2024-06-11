# Stage 1: Compile and Build angular codebase
# Use official node image as the base image
FROM node:18-alpine3.17 as build
# Set the working directory
WORKDIR /app
# Add the source code to app
COPY package.json .
# Install all the dependencies
RUN npm install
# Add the source code to app
COPY . .
# Generate the build of the application
RUN npm run build

# Stage 2: Serve app with nginx server
# Use official nginx image as the base image
FROM nginx:alpine
# Copy the nginx configuration
COPY ./nginx.conf /etc/nginx/nginx.conf
# Copy the build output to replace the default nginx contents.
COPY --from=build /app/dist/angular-docker/browser /usr/share/nginx/html
# Expose port 80
EXPOSE 80
