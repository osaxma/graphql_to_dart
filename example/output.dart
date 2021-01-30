import 'package:meta/meta.dart';

class Query {
  final String query;
  final Map<String, dynamic> variables;

  const Query({@required this.query, @required this.variables});
}

Query updateProfilePhotoURLReq(
  String uid,
  String photo_url,
) {
  return Query(
    query: updateProfilePhotoURLRawMutation,
    variables: <String, dynamic>{
      'uid': uid,
      'photo_url': photo_url,
    },
  );
}

Query updateProfileDisplayNameReq(
  String uid,
  String display_name,
) {
  return Query(
    query: updateProfileDisplayNameRawMutation,
    variables: <String, dynamic>{
      'uid': uid,
      'display_name': display_name,
    },
  );
}

Query createForoReq(
  String display_name,
  String photo_url,
  String created_by,
  String category,
) {
  return Query(
    query: createForoRawMutation,
    variables: <String, dynamic>{
      'display_name': display_name,
      'photo_url': photo_url,
      'created_by': created_by,
      'category': category,
    },
  );
}

Query joinForoReq(
  String uid,
  String foroID,
) {
  return Query(
    query: joinForoRawMutation,
    variables: <String, dynamic>{
      'uid': uid,
      'foroID': foroID,
    },
  );
}

Query leaveForoReq(
  String uid,
  String foroID,
) {
  return Query(
    query: leaveForoRawMutation,
    variables: <String, dynamic>{
      'uid': uid,
      'foroID': foroID,
    },
  );
}

Query updateForoPhotoURLReq(
  String foroID,
  String photo_url,
) {
  return Query(
    query: updateForoPhotoURLRawMutation,
    variables: <String, dynamic>{
      'foroID': foroID,
      'photo_url': photo_url,
    },
  );
}

Query updateForoDisplayNameReq(
  String foroID,
  String display_name,
) {
  return Query(
    query: updateForoDisplayNameRawMutation,
    variables: <String, dynamic>{
      'foroID': foroID,
      'display_name': display_name,
    },
  );
}

Query createPostReq(
  String post_content,
  String created_by,
  String foro_id,
) {
  return Query(
    query: createPostRawMutation,
    variables: <String, dynamic>{
      'post_content': post_content,
      'created_by': created_by,
      'foro_id': foro_id,
    },
  );
}

Query createCommentReq(
  String comment_content,
  String created_by,
  String foro_id,
  String post_id,
) {
  return Query(
    query: createCommentRawMutation,
    variables: <String, dynamic>{
      'comment_content': comment_content,
      'created_by': created_by,
      'foro_id': foro_id,
      'post_id': post_id,
    },
  );
}

Query reactToPostReq(
  String foro_id,
  String post_id,
  String reaction,
  String uid,
) {
  return Query(
    query: reactToPostRawMutation,
    variables: <String, dynamic>{
      'foro_id': foro_id,
      'post_id': post_id,
      'reaction': reaction,
      'uid': uid,
    },
  );
}

Query unReactToPostReq(
  String foro_id,
  String post_id,
  String uid,
) {
  return Query(
    query: unReactToPostRawMutation,
    variables: <String, dynamic>{
      'foro_id': foro_id,
      'post_id': post_id,
      'uid': uid,
    },
  );
}

Query reactToCommentReq(
  String foro_id,
  String post_id,
  String comment_id,
  String reaction,
  String uid,
) {
  return Query(
    query: reactToCommentRawMutation,
    variables: <String, dynamic>{
      'foro_id': foro_id,
      'post_id': post_id,
      'comment_id': comment_id,
      'reaction': reaction,
      'uid': uid,
    },
  );
}

Query unReactToCommentReq(
  String foro_id,
  String post_id,
  String comment_id,
  String uid,
) {
  return Query(
    query: unReactToCommentRawMutation,
    variables: <String, dynamic>{
      'foro_id': foro_id,
      'post_id': post_id,
      'comment_id': comment_id,
      'uid': uid,
    },
  );
}

Query createConversationReq(
  String receiver_uid,
  String sender_uid,
) {
  return Query(
    query: createConversationRawMutation,
    variables: <String, dynamic>{
      'receiver_uid': receiver_uid,
      'sender_uid': sender_uid,
    },
  );
}

Query sendMessageReq(
  String content,
  String conversation_id,
  String sender_uid,
  String parent_id,
) {
  return Query(
    query: sendMessageRawMutation,
    variables: <String, dynamic>{
      'content': content,
      'conversation_id': conversation_id,
      'sender_uid': sender_uid,
      'parent_id': parent_id,
    },
  );
}

Query getJoinedForosReq(
  String uid,
) {
  return Query(
    query: getJoinedForosRawQuery,
    variables: <String, dynamic>{
      'uid': uid,
    },
  );
}

Query getConversationIDReq(
  String uid1,
  String uid2,
) {
  return Query(
    query: getConversationIDRawQuery,
    variables: <String, dynamic>{
      'uid1': uid1,
      'uid2': uid2,
    },
  );
}

Query getConvosReq(
  String uid,
) {
  return Query(
    query: getConvosRawQuery,
    variables: <String, dynamic>{
      'uid': uid,
    },
  );
}

Query getMessagesReq(
  String conversation_id,
  String uid,
) {
  return Query(
    query: getMessagesRawQuery,
    variables: <String, dynamic>{
      'conversation_id': conversation_id,
      'uid': uid,
    },
  );
}

Query getNewestPostsReq(
  String foroID,
  String uid,
) {
  return Query(
    query: getNewestPostsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'uid': uid,
    },
  );
}

Query getOldestPostsReq(
  String foroID,
  String uid,
) {
  return Query(
    query: getOldestPostsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'uid': uid,
    },
  );
}

Query getMostLikedPostsReq(
  String foroID,
  String uid,
) {
  return Query(
    query: getMostLikedPostsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'uid': uid,
    },
  );
}

Query getMostCommentedPotsReq(
  String foroID,
  String uid,
) {
  return Query(
    query: getMostCommentedPotsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'uid': uid,
    },
  );
}

Query getPostCommentsReq(
  String foroID,
  String postID,
) {
  return Query(
    query: getPostCommentsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'postID': postID,
    },
  );
}

Query getUserProfileReq(
  String uid,
) {
  return Query(
    query: getUserProfileRawQuery,
    variables: <String, dynamic>{
      'uid': uid,
    },
  );
}

// --------------------------------------------- fragments

const profileRawFragment = ''' fragment profile on users {
  uid
  photoURL: photo_url
  displayName : display_name
  creationTime :created_at
  
} 
''';

// something to note about this query, the reaction returns as a list :/

const postFieldsRawFragment = ''' fragment postFields on posts_view {
  creationTime: created_at
  lastUpdatedTime: updated_at
  postID: post_id
  postContent: post_content
  foroID: foro_id
  reactionsCount: reactions_count
  commentsCount: comments_count
  creator : creator {
   ...profile
  }
  # computed field basd on x-hasura-user-id
  reaction : user_reaction_to_post
}
$profileRawFragment 
''';

// --------------------------------------------------------- MUTATIONS

const updateProfilePhotoURLRawMutation =
    ''' mutation  updateProfilePhotoURL(\$uid: String!, \$photo_url: String!) {
  update_users_by_pk(pk_columns: {uid: \$uid}, _set: {photo_url: \$photo_url}) {
   ...profile
  }
}
$profileRawFragment 
''';

const updateProfileDisplayNameRawMutation =
    ''' mutation updateProfileDisplayName(\$uid: String!, \$display_name: String!) {
  update_users_by_pk(pk_columns: {uid: \$uid}, _set: {display_name: \$display_name}) {
   ...profile
  }
}
$profileRawFragment 
''';

// role is not returned here and should be added on the client of the request is successful

const createForoRawMutation =
    ''' mutation createForo(\$display_name: String!, \$photo_url: String!, \$created_by: String!, \$category: String = "others") {
  insert_foros_one(object: {display_name: \$display_name, photo_url: \$photo_url, created_by: \$created_by, category: \$category}) {
  category
  foro_id: foro_id
  displayName: display_name
  photoURL: photo_url
  createdBy: created_by
  creationTime: created_at
  lastUpdatedTime: updated_at
  }
} 
''';

const joinForoRawMutation =
    ''' mutation joinForo(\$uid: String!, \$foroID: String!) {
  insert_memberships_one(object: {foro_id: \$foroID, uid: \$uid}) {
    foroID : foro_id
  }
} 
''';

const leaveForoRawMutation =
    ''' mutation leaveForo(\$uid: String!, \$foroID: String!) {
  delete_memberships(where: {foro_id: {_eq: \$foroID}, uid: {_eq: \$uid}}) {
    returning {
      foro_id
    }
  }
} 
''';

const updateForoPhotoURLRawMutation =
    ''' mutation updateForoPhotoURL(\$foroID: String!, \$photo_url: String!) {
  update_foros_by_pk(pk_columns: {foro_id: \$foroID}, _set: {photo_url: \$photo_url}) {
   ...profile
  }
}
$profileRawFragment 
''';

const updateForoDisplayNameRawMutation =
    ''' mutation updateForoDisplayName(\$foroID: String!, \$display_name: String!) {
  update_foros_by_pk(pk_columns: {foro_id: \$foroID}, _set: {display_name: \$display_name}) {
   ...profile
  }
}
$profileRawFragment 
''';

const createPostRawMutation =
    ''' mutation createPost(\$post_content: String!, \$created_by: String!, \$foro_id: String!) {
  insert_posts_one(object: {post_content: \$post_content, created_by: \$created_by, foro_id: \$foro_id}) {
    foroID : foro_id
    postID : post_id
    creationTime : created_at
    lastUpdatedTime : updated_at
    # some comment
    createdBy : created_by
  }
} 
''';

// TODO: update post

// TODO: delete post

const createCommentRawMutation =
    ''' mutation createComment(\$comment_content: String!, \$created_by: String!, \$foro_id: String!, \$post_id: String!) {
  insert_comments_one(object: {comment_content: \$comment_content, created_by: \$created_by, foro_id: \$foro_id, post_id: \$post_id}) {
    comment_content
    comment_id
    created_at
    created_by
    foro_id
    post_id
    updated_at
  }
} 
''';

// TODO: update comment

// TODO: delete comment

// react to post

const reactToPostRawMutation =
    ''' mutation reactToPost(\$foro_id: String!, \$post_id: String!, \$reaction: String! = "like", \$uid: String!) {
  insert_posts_reactions_one(object: {uid: \$uid, foro_id: \$foro_id, post_id: \$post_id, reaction: \$reaction}) {
    uid
    reaction_id
    reaction
    post_id
    foro_id
    created_at
  }
} 
''';

//  unreact to post

const unReactToPostRawMutation =
    ''' mutation unReactToPost(\$foro_id: String!, \$post_id: String!, \$uid: String!) {
  delete_posts_reactions(where: {_and: {foro_id: {_eq: \$foro_id}, post_id: {_eq: \$post_id}, uid: {_eq: \$uid}}}) {
    affected_rows
  }
} 
''';

// react to comment

const reactToCommentRawMutation =
    ''' mutation reactToComment(\$foro_id: String!, \$post_id: String!, \$comment_id: String!, \$reaction: String! = "like", \$uid: String!) {
  insert_comments_reactions_one(object: {uid: \$uid, foro_id: \$foro_id, post_id: \$post_id, comment_id: \$comment_id, reaction: \$reaction}) {
    uid
    reaction_id
    reaction
    post_id
    foro_id
    created_at
  }
} 
''';

// unreact to comment

const unReactToCommentRawMutation =
    ''' mutation unReactToComment(\$foro_id: String!, \$post_id: String!, \$comment_id: String!, \$uid: String!) {
  delete_comments_reactions(where: {_and: {foro_id: {_eq: \$foro_id}, post_id: {_eq: \$post_id}, comment_id: {_eq: \$comment_id}, uid: {_eq: \$uid}}}) {
    affected_rows
  }
} 
''';

// create conversation

const createConversationRawMutation =
    ''' mutation createConversation(\$receiver_uid: String!, \$sender_uid: String!) {
  insert_stub_create_conversation_one(object: {sender_uid: \$sender_uid, receiver_uid: \$receiver_uid}) {
    conversation_id
    receiver_uid
    sender_uid
  }
} 
''';

// send message

const sendMessageRawMutation =
    ''' mutation sendMessage(\$content: String!, \$conversation_id: String!, \$sender_uid: String!, \$parent_id: String = null,) {
  insert_messages_one(object: {content: \$content, conversation_id: \$conversation_id, sender_uid: \$sender_uid, parent_id: \$parent_id,}) {
    content
    conversation_id
    message_id
    parent_id
    sender_uid
  }
} 
''';

// --------------------------------------------------------- QUERIES

const getJoinedForosRawQuery = ''' query getJoinedForos(\$uid: String!) {
  foros_memberships(where: {uid: {_eq: \$uid}}) {
  category
  foro_id: foro_id
  displayName: display_name
  photoURL: photo_url
  lastUpdatedTime: updated_at
  postsCount : posts_count
  }
} 
''';

// TODO: getForosForExplore

// TODO: currentUserDataStream

// -------- Convos and Messages

// get conversation ID

const getConversationIDRawQuery =
    ''' query getConversationID(\$uid1: String!, \$uid2: String!) {
  get_conversation_id(args: {uid1: \$uid1, uid2: \$uid2}) {
    conversationID : result
  }
} 
''';

// get convos -- postgres requires to order by the distinct field first, maybe find an efficient way to get latest convos (instead of creating an index for conversation_id plus created_at)

const getConvosRawQuery = ''' query getConvos(\$uid: String!) {
  messages: messages_view(distinct_on: conversation_id, where: {uid: {_eq: \$uid}}, order_by: {conversation_id: asc, created_at: desc}) {
    conversationID: conversation_id
    messageContent: content
    creationTime: created_at
    isRead: is_read
    senderUID: sender_uid
  }
} 
''';

// get messages (or should we just query messages_status based on convo_id and uid)

const getMessagesRawQuery =
    ''' query getMessages(\$conversation_id: String!, \$uid: String!) {
  messages: messages_view(where: {_and: {conversation_id: {_eq: \$conversation_id}, uid: {_eq: \$uid}}}) {
    conversationID: conversation_id
    messageContent: content
    creationTime: created_at
    isRead: is_read
    senderUID: sender_uid
  }
} 
''';

// -------- Posts

const getNewestPostsRawQuery =
    ''' query getNewestPosts(\$foroID: String!, \$uid: String!) {
  posts: posts_view(where: {foro_id: {_eq: \$foroID}}, order_by: {created_at: asc}) {
    ...postFields
  }
}
$postFieldsRawFragment 
''';

const getOldestPostsRawQuery =
    ''' query getOldestPosts(\$foroID: String!, \$uid: String!) {
  posts: posts_view(where: {foro_id: {_eq: \$foroID}}, order_by: {created_at: desc}) {
    ...postFields
  }
}
$postFieldsRawFragment 
''';

const getMostLikedPostsRawQuery =
    ''' query getMostLikedPosts(\$foroID: String!, \$uid: String!) {
  posts: posts_view(where: {foro_id: {_eq: \$foroID}}, order_by: {reactions_count: desc}) {
    ...postFields
  }
}
$postFieldsRawFragment 
''';

const getMostCommentedPotsRawQuery =
    ''' query getMostCommentedPots(\$foroID: String!, \$uid: String!) {
  posts: posts_view(where: {foro_id: {_eq: \$foroID}}, order_by: {comments_count: desc}) {
    ...postFields
  }
}
$postFieldsRawFragment 
''';

/* variable example:
{
  "foro_id": "######",
  "post_id": ""######",",
  "comment_content": "some content",
  "created_by": "uid"
}

 */

const getPostCommentsRawQuery =
    ''' query getPostComments(\$foroID: String!, \$postID: String!) {
  comments : comments_view(where: {_and: {foro_id: {_eq: \$foroID}, post_id: {_eq: \$postID}}}) {
    creationTime : created_at
    reactionsCount : reactions_count
    commentContent:comment_content
    creator {
      ...profile
    }
  }
}
$profileRawFragment 
''';

// ---------- Profile

const getUserProfileRawQuery = ''' query getUserProfile(\$uid: String!) {
 
} 
''';
