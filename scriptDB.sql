create schema social_network;

Set search_path to social_network;

CREATE SEQUENCE IF NOT EXISTS followers_id_follower_seq;
CREATE SEQUENCE IF NOT EXISTS followers_id_followed_seq;

CREATE TABLE IF NOT EXISTS followers (
  id_follower integer NOT NULL DEFAULT nextval('followers_id_follower_seq'),
  id_followed integer NOT NULL DEFAULT nextval('followers_id_followed_seq')
);

CREATE SEQUENCE IF NOT EXISTS posts_id_post_seq;
CREATE SEQUENCE IF NOT EXISTS posts_id_creator_post_seq;
CREATE SEQUENCE IF NOT EXISTS posts_id_type_post_seq;

CREATE TABLE IF NOT EXISTS posts (
  id_post integer NOT NULL DEFAULT nextval('posts_id_post_seq') PRIMARY KEY,
  id_creator_post integer NOT NULL DEFAULT nextval('posts_id_creator_post_seq'),
  id_type_post integer DEFAULT nextval('posts_id_type_post_seq'),
  caption_post varchar,
  place_post varchar,
  crated_datetime_post date
);

CREATE SEQUENCE IF NOT EXISTS users_id_user_seq;

CREATE TABLE IF NOT EXISTS users (
  id_user integer NOT NULL DEFAULT nextval('users_id_user_seq') PRIMARY KEY,
  first_name_user varchar,
  last_name_user varchar,
  profile_name_user varchar
);

CREATE SEQUENCE IF NOT EXISTS filters_id_filter_seq;

CREATE TABLE IF NOT EXISTS filters (
  id_filter integer NOT NULL DEFAULT nextval('filters_id_filter_seq') PRIMARY KEY,
  name_filter varchar,
  details_filter varchar
);

CREATE SEQUENCE IF NOT EXISTS reactions_id_post_reaction_seq;
CREATE SEQUENCE IF NOT EXISTS reactions_id_user_reaction_seq;

CREATE TABLE IF NOT EXISTS reactions (
  id_post_reaction integer NOT NULL DEFAULT nextval('reactions_id_post_reaction_seq'),
  id_user_reaction integer NOT NULL DEFAULT nextval('reactions_id_user_reaction_seq')
);

CREATE SEQUENCE IF NOT EXISTS comments_comment_id_seq;
CREATE SEQUENCE IF NOT EXISTS comments_id_post_comment_seq;
CREATE SEQUENCE IF NOT EXISTS comments_id_creator_comment_seq;

CREATE TABLE IF NOT EXISTS comments (
  comment_id integer NOT NULL DEFAULT nextval('comments_comment_id_seq') PRIMARY KEY,
  id_post_comment integer DEFAULT nextval('comments_id_post_comment_seq'),
  id_creator_comment integer DEFAULT nextval('comments_id_creator_comment_seq'),
  content_comment varchar,
  created_datetime_comment date
);

CREATE SEQUENCE IF NOT EXISTS messages_id_message_seq;
CREATE SEQUENCE IF NOT EXISTS messages_id_sender_message_seq;
CREATE SEQUENCE IF NOT EXISTS messages_id_receiver_message_seq;

CREATE TABLE IF NOT EXISTS messages (
  id_message integer NOT NULL DEFAULT nextval('messages_id_message_seq') PRIMARY KEY,
  id_sender_message integer DEFAULT nextval('messages_id_sender_message_seq'),
  id_receiver_message integer DEFAULT nextval('messages_id_receiver_message_seq'),
  content_message varchar
);

CREATE SEQUENCE IF NOT EXISTS post_types_id_post_type_seq;

CREATE TABLE IF NOT EXISTS post_types (
  id_post_type integer NOT NULL DEFAULT nextval('post_types_id_post_type_seq') PRIMARY KEY,
  name_type varchar
);

CREATE SEQUENCE IF NOT EXISTS post_media_id_post_media_seq;
CREATE SEQUENCE IF NOT EXISTS post_media_id_filter_media_seq;
CREATE SEQUENCE IF NOT EXISTS post_media_id_post_seq;

CREATE TABLE IF NOT EXISTS post_media (
  id_post_media integer NOT NULL DEFAULT nextval('post_media_id_post_media_seq') PRIMARY KEY,
  id_filter_media integer DEFAULT nextval('post_media_id_filter_media_seq'),
  id_post integer not null default nextval('post_media_id_post_seq'),
  file_post_media bigint
);

ALTER TABLE followers ADD CONSTRAINT followers_user_fk FOREIGN KEY (id_follower) REFERENCES users (id_user);
ALTER TABLE followers ADD CONSTRAINT followed_user_fk FOREIGN KEY (id_followed) REFERENCES users (id_user);
ALTER TABLE posts ADD CONSTRAINT creator_user_fk FOREIGN KEY (id_creator_post) REFERENCES users (id_user);
ALTER TABLE posts ADD CONSTRAINT type_post_fk FOREIGN KEY (id_type_post) REFERENCES post_types (id_post_type);
ALTER TABLE reactions ADD CONSTRAINT post_reaction_fk FOREIGN KEY (id_post_reaction) REFERENCES posts (id_post);
ALTER TABLE reactions ADD CONSTRAINT user_reaction_fk FOREIGN KEY (id_user_reaction) REFERENCES users (id_user);
ALTER TABLE comments ADD CONSTRAINT post_comment_fk FOREIGN KEY (id_post_comment) REFERENCES posts (id_post);
ALTER TABLE comments ADD CONSTRAINT creator_comment_fk FOREIGN KEY (id_creator_comment) REFERENCES users (id_user);
ALTER TABLE messages ADD CONSTRAINT sender_message_fk FOREIGN KEY (id_sender_message) REFERENCES users (id_user);
ALTER TABLE messages ADD CONSTRAINT receiver_message_fk FOREIGN KEY (id_receiver_message) REFERENCES users (id_user);
ALTER TABLE post_media ADD CONSTRAINT post_media_fk FOREIGN KEY (id_post) REFERENCES posts (id_post);
ALTER TABLE post_media ADD CONSTRAINT filter_media_fk FOREIGN KEY (id_filter_media) REFERENCES filters (id_filter);