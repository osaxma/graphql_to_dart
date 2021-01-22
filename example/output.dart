import 'package:meta/meta.dart';

class Query {
  final String query;
  final Map<String, dynamic> variables;

  const Query({@required this.query, @required this.variables});
}

Query updateProfilePhotoURL(
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

Query updateProfileDisplayName(
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

Query createForo(
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

Query joinForo(
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

Query leaveForo(
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

Query updateForoPhotoURL(
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

Query updateForoDisplayName(
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

Query someQueryWithoutArguments() {
  return Query(
    query: someQueryWithoutArgumentsRawQuery,
    variables: <String, dynamic>{},
  );
}

Query createPost(
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

Query createComment(
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

Query reactToPost(
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

Query unReactToPost(
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

Query whatAquery() {
  return Query(
    query: whatAqueryRawQuery,
    variables: <String, dynamic>{},
  );
}

Query reactToComment(
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

Query unReactToComment(
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

Query getJoinedForos(
  String uid,
) {
  return Query(
    query: getJoinedForosRawQuery,
    variables: <String, dynamic>{
      'uid': uid,
    },
  );
}

Query getNewestPosts(
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

Query getOldestPosts(
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

Query getMostLikedPosts(
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

Query getMostCommentedPots(
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

Query getPostComments(
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

Query getUserProfile(
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
  creator {
   $profileRawFragment
  }
  # TODO: change reaction to a computed field to flatten the query 
  reaction: reactions_to_post(where: {uid: {_eq: \$uid}}) {
    reaction
  }
} 
''';

// --------------------------------------------------------- MUTATIONS

const updateProfilePhotoURLRawMutation =
    ''' mutation  updateProfilePhotoURL(\$uid: String!, \$photo_url: String!) {
  update_users_by_pk(pk_columns: {uid: \$uid}, _set: {photo_url: \$photo_url}) {
   $profileRawFragment
  }
} 
''';

const updateProfileDisplayNameRawMutation =
    ''' mutation updateProfileDisplayName(\$uid: String!, \$display_name: String!) {
  update_users_by_pk(pk_columns: {uid: \$uid}, _set: {display_name: \$display_name}) {
   $profileRawFragment
  }
} 
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
   $profileRawFragment
  }
} 
''';

const updateForoDisplayNameRawMutation =
    ''' mutation updateForoDisplayName(\$foroID: String!, \$display_name: String!) {
  update_foros_by_pk(pk_columns: {foro_id: \$foroID}, _set: {display_name: \$display_name}) {
   $profileRawFragment
  }
} 
''';

const someQueryWithoutArgumentsRawQuery = ''' query someQueryWithoutArguments  {

} 
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

// TODO: react to post

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

// TODO: unreact to post

const unReactToPostRawMutation =
    ''' mutation unReactToPost(\$foro_id: String!, \$post_id: String!, \$uid: String!) {
  delete_posts_reactions(where: {_and: {foro_id: {_eq: \$foro_id}, post_id: {_eq: \$post_id}, uid: {_eq: \$uid}}}) {
    affected_rows
  }
} 
''';

const whatAqueryRawQuery = ''' query whatAquery { 

} 
''';

// TODO: react to comment

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

// TODO: unreact to comment

const unReactToCommentRawMutation =
    ''' mutation unReactToComment(\$foro_id: String!, \$post_id: String!, \$comment_id: String!, \$uid: String!) {
  delete_comments_reactions(where: {_and: {foro_id: {_eq: \$foro_id}, post_id: {_eq: \$post_id}, comment_id: {_eq: \$comment_id}, uid: {_eq: \$uid}}}) {
    affected_rows
  }
} 
''';

// TODO: send message

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

/* single line comment */

/* example input data 
{
    "foro_id": "01EVV6HFZBSE4RM2MKTSJ7C500"
    "created_by": "uid",
    "post_content":"some content",
}
*/

const getNewestPostsRawQuery =
    ''' query getNewestPosts(\$foroID: String!, \$uid: String!) {
  posts: posts_view(where: {foro_id: {_eq: \$foroID}}, order_by: {created_at: asc}) {
    $postFieldsRawFragment
  }
} 
''';

const getOldestPostsRawQuery =
    ''' query getOldestPosts(\$foroID: String!, \$uid: String!) {
  posts: posts_view(where: {foro_id: {_eq: \$foroID}}, order_by: {created_at: desc}) {
    $postFieldsRawFragment
  }
} 
''';

const getMostLikedPostsRawQuery =
    ''' query getMostLikedPosts(\$foroID: String!, \$uid: String!) {
  posts: posts_view(where: {foro_id: {_eq: \$foroID}}, order_by: {reactions_count: desc}) {
    $postFieldsRawFragment
  }
} 
''';

const getMostCommentedPotsRawQuery =
    ''' query getMostCommentedPots(\$foroID: String!, \$uid: String!) {
  posts: posts_view(where: {foro_id: {_eq: \$foroID}}, order_by: {comments_count: desc}) {
    $postFieldsRawFragment
  }
} 
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
      $profileRawFragment
    }
  }
} 
''';

// ---------- Profile

const getUserProfileRawQuery = ''' query getUserProfile(\$uid: String!) {
 
} 
''';
