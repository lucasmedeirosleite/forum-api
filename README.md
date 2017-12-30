## Exposed API

### Structures

```javascript
const date_s = string('UTC date on format YYYY-MM-DD HH:mm:ss')

const User = {
  id: number,
  name: string,
  email: string
}

const Post = {
  id: number,
  description: string,
  date: date_s,
  topic_id: number,
  user: User
}

const Topic = {
  id: number,
  title: string,
  description: string,
  date: date_s,
  posts_count: number // optional
  posts: [Post] // optional
  user: User,
}
```

### ENDPOINTS

HTTP METHOD| Path | Returns | Status | Description
--- | --- | --- | --- | ---
POST | /topics/:topic_id/posts | Post | 200, 401, 404, 422, 500 | Creates a new topic post
DELETE | /topics/:topic_id/posts/:id | nothing | 204, 401, 404, 500 | Deletes the specified topic post 
GET | /topics | [Topic] | 200, 401, 500 | List all topics (or filtered by term) ordered by date (desc)
POST | /topics | Topic | 201, 401, 422, 500 | Creates a new topic
GET | /topics/:id | Topic | 200, 401, 404, 500 | One specific topic
PATCH | /topics/:id | Topic | 200, 401, 404, 422, 500 | Updates the specfied topic
DELETE | /topics/:id | nothing | 204, 401, 404, 500 | Deletes a specified topic
POST | /users | User | 201, 401, 422, 500 | Creates new user account
POST | /users/sign_in | User | 200, 401, 500 | Signs in the user with passed credentials
DELETE | /users/sign_out | nothing | 204, 401, 500 | Signs out the user linked to the passed token

