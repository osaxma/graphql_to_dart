//
// Generated file. Do not edit.
//
class Query {
  final String query;
  final Map<String, dynamic> variables;

  Query({required this.query, Map<String, dynamic> variables = const {}})
      // to handle default values that passed as null
      : variables = variables..removeWhere((key, value) => value == null);

  @override
  String toString() {
    return 'operation:\n$query\nvariables:\n$variables';
  }
}

class SortOrder {
  /// in the ascending order, nulls last
  static const asc = 'asc';

  /// in the ascending order, nulls first
  static const ascNullsFirst = 'asc_nulls_first';

  /// in the ascending order, nulls last
  static const ascNullsLast = 'asc_nulls_last';

  /// in the descending order, nulls first
  static const desc = 'desc';

  /// in the descending order, nulls first
  static const descNullsFirst = 'desc_nulls_first';

  /// in the descending order, nulls last
  static const descNullsLast = 'desc_nulls_last';
}

// --------------------------------------------- fragments

const _profileRawFragment = ''' fragment profile on users {
  uid
  photoURL: photo_url
  displayName : display_name
  creationTime :created_at
  
} 
''';

// something to note about this query, the reaction returns as a list :/

const _postFieldsRawFragment = ''' fragment postFields on posts_view {
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
$_profileRawFragment 
''';

Query updateProfilePhotoURLReq(
  String uid,
  String photoUrl,
) {
  return Query(
    query: _updateProfilePhotoURLRawMutation,
    variables: <String, dynamic>{
      'uid': uid,
      'photo_url': photoUrl,
    },
  );
}

// --------------------------------------------------------- MUTATIONS

const _updateProfilePhotoURLRawMutation =
    ''' mutation  updateProfilePhotoURL(\$uid: String!, \$photo_url: String!) {
  update_users_by_pk(pk_columns: {uid: \$uid}, _set: {photo_url: \$photo_url}) {
   ...profile
  }
}
$_profileRawFragment 
''';

Query updateProfileDisplayNameReq(
  String uid,
  String displayName,
) {
  return Query(
    query: _updateProfileDisplayNameRawMutation,
    variables: <String, dynamic>{
      'uid': uid,
      'display_name': displayName,
    },
  );
}

const _updateProfileDisplayNameRawMutation =
    ''' mutation updateProfileDisplayName(\$uid: String!, \$display_name: String!) {
  update_users_by_pk(pk_columns: {uid: \$uid}, _set: {display_name: \$display_name}) {
   ...profile
  }
}
$_profileRawFragment 
''';

Query createForoReq(
  String displayName,
  String photoUrl,
  String createdBy, {
  String? category,
}) {
  return Query(
    query: _createForoRawMutation,
    variables: <String, dynamic>{
      'display_name': displayName,
      'photo_url': photoUrl,
      'created_by': createdBy,
      'category': category,
    },
  );
}

// role is not returned here and should be added on the client of the request is successful

const _createForoRawMutation =
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

Query joinForoReq(
  String uid,
  String foroID,
) {
  return Query(
    query: _joinForoRawMutation,
    variables: <String, dynamic>{
      'uid': uid,
      'foroID': foroID,
    },
  );
}

const _joinForoRawMutation =
    ''' mutation joinForo(\$uid: String!, \$foroID: String!) {
  insert_memberships_one(object: {foro_id: \$foroID, uid: \$uid}) {
    foroID : foro_id
  }
} 
''';

Query leaveForoReq(
  String uid,
  String foroID,
) {
  return Query(
    query: _leaveForoRawMutation,
    variables: <String, dynamic>{
      'uid': uid,
      'foroID': foroID,
    },
  );
}

const _leaveForoRawMutation =
    ''' mutation leaveForo(\$uid: String!, \$foroID: String!) {
  delete_memberships(where: {foro_id: {_eq: \$foroID}, uid: {_eq: \$uid}}) {
    returning {
      foro_id
    }
  }
} 
''';

Query updateForoPhotoURLReq(
  String foroID,
  String photoUrl,
) {
  return Query(
    query: _updateForoPhotoURLRawMutation,
    variables: <String, dynamic>{
      'foroID': foroID,
      'photo_url': photoUrl,
    },
  );
}

const _updateForoPhotoURLRawMutation =
    ''' mutation updateForoPhotoURL(\$foroID: String!, \$photo_url: String!) {
  update_foros_by_pk(pk_columns: {foro_id: \$foroID}, _set: {photo_url: \$photo_url}) {
   ...profile
  }
}
$_profileRawFragment 
''';

Query updateForoDisplayNameReq(
  String foroID,
  String displayName,
) {
  return Query(
    query: _updateForoDisplayNameRawMutation,
    variables: <String, dynamic>{
      'foroID': foroID,
      'display_name': displayName,
    },
  );
}

const _updateForoDisplayNameRawMutation =
    ''' mutation updateForoDisplayName(\$foroID: String!, \$display_name: String!) {
  update_foros_by_pk(pk_columns: {foro_id: \$foroID}, _set: {display_name: \$display_name}) {
   ...profile
  }
}
$_profileRawFragment 
''';

Query createPostReq(
  String postContent,
  String createdBy,
  String foroId,
) {
  return Query(
    query: _createPostRawMutation,
    variables: <String, dynamic>{
      'post_content': postContent,
      'created_by': createdBy,
      'foro_id': foroId,
    },
  );
}

const _createPostRawMutation =
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

Query createCommentReq(
  String commentContent,
  String createdBy,
  String foroId,
  String postId,
) {
  return Query(
    query: _createCommentRawMutation,
    variables: <String, dynamic>{
      'comment_content': commentContent,
      'created_by': createdBy,
      'foro_id': foroId,
      'post_id': postId,
    },
  );
}

// TODO: update post

// TODO: delete post

const _createCommentRawMutation =
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

Query reactToPostReq(
  String foroId,
  String postId,
  String uid, {
  String? reaction,
}) {
  return Query(
    query: _reactToPostRawMutation,
    variables: <String, dynamic>{
      'foro_id': foroId,
      'post_id': postId,
      'uid': uid,
      'reaction': reaction,
    },
  );
}

// TODO: update comment

// TODO: delete comment

// react to post

const _reactToPostRawMutation =
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

Query unReactToPostReq(
  String foroId,
  String postId,
  String uid,
) {
  return Query(
    query: _unReactToPostRawMutation,
    variables: <String, dynamic>{
      'foro_id': foroId,
      'post_id': postId,
      'uid': uid,
    },
  );
}

//  unreact to post

const _unReactToPostRawMutation =
    ''' mutation unReactToPost(\$foro_id: String!, \$post_id: String!, \$uid: String!) {
  delete_posts_reactions(where: {_and: {foro_id: {_eq: \$foro_id}, post_id: {_eq: \$post_id}, uid: {_eq: \$uid}}}) {
    affected_rows
  }
} 
''';

Query reactToCommentReq(
  String foroId,
  String postId,
  String commentId,
  String uid, {
  String? reaction,
}) {
  return Query(
    query: _reactToCommentRawMutation,
    variables: <String, dynamic>{
      'foro_id': foroId,
      'post_id': postId,
      'comment_id': commentId,
      'uid': uid,
      'reaction': reaction,
    },
  );
}

// react to comment

const _reactToCommentRawMutation =
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

Query unReactToCommentReq(
  String foroId,
  String postId,
  String commentId,
  String uid,
) {
  return Query(
    query: _unReactToCommentRawMutation,
    variables: <String, dynamic>{
      'foro_id': foroId,
      'post_id': postId,
      'comment_id': commentId,
      'uid': uid,
    },
  );
}

// unreact to comment

const _unReactToCommentRawMutation =
    ''' mutation unReactToComment(\$foro_id: String!, \$post_id: String!, \$comment_id: String!, \$uid: String!) {
  delete_comments_reactions(where: {_and: {foro_id: {_eq: \$foro_id}, post_id: {_eq: \$post_id}, comment_id: {_eq: \$comment_id}, uid: {_eq: \$uid}}}) {
    affected_rows
  }
} 
''';

Query createConversationReq(
  String receiverUid,
  String senderUid,
) {
  return Query(
    query: _createConversationRawMutation,
    variables: <String, dynamic>{
      'receiver_uid': receiverUid,
      'sender_uid': senderUid,
    },
  );
}

// create conversation

const _createConversationRawMutation =
    ''' mutation createConversation(\$receiver_uid: String!, \$sender_uid: String!) {
  insert_stub_create_conversation_one(object: {sender_uid: \$sender_uid, receiver_uid: \$receiver_uid}) {
    conversation_id
    receiver_uid
    sender_uid
  }
} 
''';

Query sendMessageReq(
  String content,
  String conversationId,
  String senderUid, {
  String? parentId,
}) {
  return Query(
    query: _sendMessageRawMutation,
    variables: <String, dynamic>{
      'content': content,
      'conversation_id': conversationId,
      'sender_uid': senderUid,
      'parent_id': parentId,
    },
  );
}

// send message

const _sendMessageRawMutation =
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

Query getJoinedForosReq(
  String uid,
) {
  return Query(
    query: _getJoinedForosRawQuery,
    variables: <String, dynamic>{
      'uid': uid,
    },
  );
}

// --------------------------------------------------------- QUERIES

const _getJoinedForosRawQuery = ''' query getJoinedForos(\$uid: String!) {
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

Query getConversationIDReq(
  String uid1,
  String uid2,
) {
  return Query(
    query: _getConversationIDRawQuery,
    variables: <String, dynamic>{
      'uid1': uid1,
      'uid2': uid2,
    },
  );
}

// TODO: getForosForExplore

// TODO: currentUserDataStream

// -------- Convos and Messages

// get conversation ID

const _getConversationIDRawQuery =
    ''' query getConversationID(\$uid1: String!, \$uid2: String!) {
  get_conversation_id(args: {uid1: \$uid1, uid2: \$uid2}) {
    conversationID : result
  }
} 
''';

Query getConvosReq(
  String uid,
) {
  return Query(
    query: _getConvosRawQuery,
    variables: <String, dynamic>{
      'uid': uid,
    },
  );
}

// get convos -- postgres requires to order by the distinct field first, maybe find an efficient way to get latest convos (instead of creating an index for conversation_id plus created_at)

const _getConvosRawQuery = ''' query getConvos(\$uid: String!) {
  messages: messages_view(distinct_on: conversation_id, where: {uid: {_eq: \$uid}}, order_by: {conversation_id: asc, created_at: desc}) {
    conversationID: conversation_id
    messageContent: content
    creationTime: created_at
    isRead: is_read
    senderUID: sender_uid
  }
} 
''';

Query getMessagesReq(
  String conversationId,
  String uid,
) {
  return Query(
    query: _getMessagesRawQuery,
    variables: <String, dynamic>{
      'conversation_id': conversationId,
      'uid': uid,
    },
  );
}

// get messages (or should we just query messages_status based on convo_id and uid)

const _getMessagesRawQuery =
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

Query getNewestPostsReq(
  String foroID,
  String uid,
) {
  return Query(
    query: _getNewestPostsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'uid': uid,
    },
  );
}

// -------- Posts

const _getNewestPostsRawQuery =
    ''' query getNewestPosts(\$foroID: String!, \$uid: String!) {
  posts: posts_view(where: {foro_id: {_eq: \$foroID}}, order_by: {created_at: asc}) {
    ...postFields
  }
}
$_postFieldsRawFragment 
''';

Query getOldestPostsReq(
  String foroID,
  String uid,
) {
  return Query(
    query: _getOldestPostsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'uid': uid,
    },
  );
}

const _getOldestPostsRawQuery =
    ''' query getOldestPosts(\$foroID: String!, \$uid: String!) {
  posts: posts_view(where: {foro_id: {_eq: \$foroID}}, order_by: {created_at: desc}) {
    ...postFields
  }
}
$_postFieldsRawFragment 
''';

Query getMostLikedPostsReq(
  String foroID,
  String uid,
) {
  return Query(
    query: _getMostLikedPostsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'uid': uid,
    },
  );
}

const _getMostLikedPostsRawQuery =
    ''' query getMostLikedPosts(\$foroID: String!, \$uid: String!) {
  posts: posts_view(where: {foro_id: {_eq: \$foroID}}, order_by: {reactions_count: desc}) {
    ...postFields
  }
}
$_postFieldsRawFragment 
''';

Query getMostCommentedPotsReq(
  String foroID,
  String uid,
) {
  return Query(
    query: _getMostCommentedPotsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'uid': uid,
    },
  );
}

const _getMostCommentedPotsRawQuery =
    ''' query getMostCommentedPots(\$foroID: String!, \$uid: String!) {
  posts: posts_view(where: {foro_id: {_eq: \$foroID}}, order_by: {comments_count: desc}) {
    ...postFields
  }
}
$_postFieldsRawFragment 
''';

Query getPostCommentsReq(
  String foroID,
  String postID,
) {
  return Query(
    query: _getPostCommentsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'postID': postID,
    },
  );
}

/* variable example:
{
  "foro_id": "######",
  "post_id": ""######",",
  "comment_content": "some content",
  "created_by": "uid"
}

 */

const _getPostCommentsRawQuery =
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
$_profileRawFragment 
''';

Query getUserProfileReq(
  String uid,
) {
  return Query(
    query: _getUserProfileRawQuery,
    variables: <String, dynamic>{
      'uid': uid,
    },
  );
}

// ---------- Profile

const _getUserProfileRawQuery = ''' query getUserProfile(\$uid: String!) {
 
} 
''';
