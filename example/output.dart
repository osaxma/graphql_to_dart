//
// Generated file. Do not edit.
//
class Query {
  final String query;
  final Map<String, dynamic> variables;

  Query({required String query, Map<String, dynamic> variables = const {}})
      // to handle default values that passed as null
      : variables = variables..removeWhere((key, value) => value == null),
        query = _removeDuplicateFragments(query);

  @override
  String toString() {
    return 'operation:\n$query\nvariables:\n$variables';
  }
}

// a temporary work around to remove duplicate fragemtns to avoid the following error:
//  `multiple definitions for fragment "FragmentName"`
// this may fail if the closing curly bracket of the fragment has whitespace before it.
final _captureAllFragements =
    RegExp(r'fragment.*\{(.|\n)+?^\}', multiLine: true);
String _removeDuplicateFragments(String string) {
  if (!string.contains('fragment')) return string;
  final matches = _captureAllFragements.allMatches(string).toList();
  if (matches.isEmpty) return string;
  final uniqueFragments = matches.map((m) => m.group(0)).toSet().reduce(
        (pre, ele) => (pre ?? '') + '\n\n' + (ele ?? ''),
      );
  string = string.replaceAll(_captureAllFragements, '').trim() +
      '\n\n' +
      uniqueFragments!;
  return string;
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

// FRAGMENTS

const _profileRawFragment = '''fragment Profile on users {
  uid : uid
  photoURL: photo_url
  displayName : display_name
  creationTime : created_at
  lastUpdatedTime : updated_at
  country : country 
}
''';

const _foroRawFragment = '''fragment Foro on foros {
  category: category
  creationTime: created_at
  displayName: display_name
  foroID: foro_id
  lastUpdatedTime: updated_at
  postsCount: posts_count
  createdByUID: created_by
  description: description
  language: language
  country: country
  membership: user_membership {
    ...Membership
  }
}
$_membershipRawFragment
''';

const _membershipRawFragment = '''fragment Membership on memberships {
  role: role
  joinedAt: joined_at
  membershipID: membership_id
  uid: uid
  foroID: foro_id
  unseenPosts : unseen_posts
}
''';

const _convoRawFragment = '''fragment Convo on inbox_view {
  otherUID: other_uid
  lastMessageContent: content
  lastUpdatedTime: last_updated_time
  unreadMessagesCount: unread_messages
  otherProfile: other_profile {
    ...Profile
  }
}
$_profileRawFragment
''';

const _messageRawFragment = '''fragment Message on messages_view {
  messageID: message_id
  messageContent: content
  isSender: is_sender
  otherUID: other_uid
  isRead: is_read
  isSeen: is_seen
  creationTime: created_at
  uid: uid
  senderLocalMessageID: sender_local_message_id
  parentID: parent_id
}
''';

// NOTE: any operation uses this fragment must have the following in its parameters:
//     - `$withCreatorProfile: Boolean!`

const _postRawFragment = '''fragment Post on posts {
  creationTime: created_at
  lastUpdatedTime: updated_at
  postID: post_id
  postContent: post_content
  foroID: foro_id
  reactionsCount: reactions_count
  commentsCount: comments_count
  # computed field basd on x-hasura-user-id
  reaction : user_reaction_to_post
  title : title
  createdByUID : created_by
  isSeen : is_seen
  creator: creator @include(if: \$withCreatorProfile) {
    ...Profile
  }
}
$_profileRawFragment
''';

// NOTE: any operation uses this fragment must have the following in its parameters:
//     - `$withCreatorProfile: Boolean!`
//     - `$withPost: Boolean!`

const _commentRawFragment = '''fragment Comment on comments {
    commentID : comment_id
    postID : post_id
    foroID : foro_id
    creationTime : created_at
    reactionsCount : reactions_count
    commentContent : comment_content
    lastUpdatedTime : updated_at
    reaction : user_reaction_to_comment
    createdByUID: created_by
    creator: creator @include(if: \$withCreatorProfile) {
    ...Profile
  }
    post: post @include(if: \$withPost) {
    ...Post
  }
}
$_profileRawFragment
$_postRawFragment
''';

const _notificationRawFragment = '''fragment Notification on notifications {
  notificationID: notification_id
  notificationType: notification_type
  creationTime: created_at
  lastUpdatedTime : updated_at
  isSeen: is_seen
  isRead: is_read
  notifierProfile: notifier_profile {
    ...Profile
  }
  # json object where keys are defined in the notification_types table
  notificationDetails: notification_details
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
    '''mutation UpdateProfilePhotoURL(\$uid: String!, \$photo_url: String!) {
  profile : update_users_by_pk(pk_columns: {uid: \$uid}, _set: {photo_url: \$photo_url}) {
   photoURL : photo_url
  }
}
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
    '''mutation UpdateProfileDisplayName(\$uid: String!, \$display_name: String!) {
  profile : update_users_by_pk(pk_columns: {uid: \$uid}, _set: {display_name: \$display_name}) {
   displayName : display_name
  }
}
''';

Query updateProfileCountryReq(
  String uid,
  String country,
) {
  return Query(
    query: _updateProfileCountryRawMutation,
    variables: <String, dynamic>{
      'uid': uid,
      'country': country,
    },
  );
}

const _updateProfileCountryRawMutation =
    '''mutation UpdateProfileCountry(\$uid: String!, \$country: String!) {
  profile : update_users_by_pk(pk_columns: {uid: \$uid}, _set: {country: \$country}) {
   country : country
  }
}
''';

Query createForoReq(
  String displayName,
  String description, {
  String? category,
}) {
  return Query(
    query: _createForoRawMutation,
    variables: <String, dynamic>{
      'display_name': displayName,
      'description': description,
      'category': category,
    },
  );
}

// role is not returned here and should be added on the client if the request is successful

const _createForoRawMutation =
    '''mutation CreateForo(\$display_name: String!, \$description: String!, \$category: String = "others") {
  foro : insert_foros_one(object: {display_name: \$display_name, description: \$description, category: \$category}) {
  ...Foro
  }
}
$_foroRawFragment
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
    '''mutation JoinForo(\$uid: String!, \$foroID: String!) {
  insert_memberships_one(object: {foro_id: \$foroID, uid: \$uid}) {
    role : role
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
    '''mutation LeaveForo(\$uid: String!, \$foroID: String!) {
  delete_memberships(where: {foro_id: {_eq: \$foroID}, uid: {_eq: \$uid}}) {
     __typename
  }
}
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
    '''mutation UpdateForoDisplayName(\$foroID: String!, \$display_name: String!) {
 foro :  update_foros_by_pk(pk_columns: {foro_id: \$foroID}, _set: {display_name: \$display_name}) {
    displayName : display_name
  }
}
''';

Query createPostReq(
  String postContent,
  String title,
  String foroId, {
  bool withCreatorProfile = false,
}) {
  return Query(
    query: _createPostRawMutation,
    variables: <String, dynamic>{
      'post_content': postContent,
      'title': title,
      'foro_id': foroId,
      'withCreatorProfile': withCreatorProfile,
    },
  );
}

const _createPostRawMutation =
    '''mutation CreatePost(\$post_content: String!, \$title: String!, \$foro_id: String!, \$withCreatorProfile: Boolean! = false) {
 post : insert_posts_one(object: {post_content: \$post_content, title: \$title, foro_id: \$foro_id}) {
    ...Post
  }
}
$_postRawFragment
''';

Query updatePostReq(
  String postId,
  String postContent, {
  bool withCreatorProfile = false,
}) {
  return Query(
    query: _updatePostRawMutation,
    variables: <String, dynamic>{
      'post_id': postId,
      'post_content': postContent,
      'withCreatorProfile': withCreatorProfile,
    },
  );
}

const _updatePostRawMutation =
    '''mutation UpdatePost(\$post_id: String!, \$post_content: String!, \$withCreatorProfile: Boolean! = false) {
  post: update_posts_by_pk(pk_columns: {post_id: \$post_id}, _set: {post_content: \$post_content}) {
    ...Post
  }
}
$_postRawFragment
''';

Query deletePostReq(
  String postId,
) {
  return Query(
    query: _deletePostRawMutation,
    variables: <String, dynamic>{
      'post_id': postId,
    },
  );
}

const _deletePostRawMutation = '''mutation DeletePost(\$post_id: String!) {
  delete_posts_by_pk(post_id: \$post_id) {
    __typename
  }
}
''';

Query createCommentReq(
  String postID,
  String commentContent, {
  bool withCreatorProfile = false,
  bool withPost = false,
}) {
  return Query(
    query: _createCommentRawMutation,
    variables: <String, dynamic>{
      'postID': postID,
      'commentContent': commentContent,
      'withCreatorProfile': withCreatorProfile,
      'withPost': withPost,
    },
  );
}

const _createCommentRawMutation =
    '''mutation CreateComment(\$postID: String!, \$commentContent: String!, \$withCreatorProfile: Boolean! = false, \$withPost: Boolean! = false) {
  comment: insert_comments_one(object: {post_id: \$postID, comment_content: \$commentContent}) {
    ...Comment
  }
}
$_commentRawFragment
''';

Query updateCommentReq(
  String commentId,
  String commentContent, {
  bool withCreatorProfile = false,
  bool withPost = false,
}) {
  return Query(
    query: _updateCommentRawMutation,
    variables: <String, dynamic>{
      'comment_id': commentId,
      'comment_content': commentContent,
      'withCreatorProfile': withCreatorProfile,
      'withPost': withPost,
    },
  );
}

const _updateCommentRawMutation =
    '''mutation UpdateComment(\$comment_id: String!, \$comment_content: String!, \$withCreatorProfile: Boolean! = false, \$withPost: Boolean! = false) {
  comment : update_comments_by_pk(pk_columns: {comment_id: \$comment_id}, _set: {comment_content: \$comment_content}) {
    ...Comment
  }
}
$_commentRawFragment
''';

Query deleteCommentReq(
  String commentId,
) {
  return Query(
    query: _deleteCommentRawMutation,
    variables: <String, dynamic>{
      'comment_id': commentId,
    },
  );
}

// the comments table have a trigger that will do the following:
// if the comment has no replies, delete it.
// if the comment has replies, update it (affected rows = 0) & mark it as ['comment was deleted'] and change the `created_by` to a 'ghost' user (similar to github)
// the query will return null for the second case
// maybe when hasura 1.4, which will support tracking volatile functions, we can use a function instead.

const _deleteCommentRawMutation =
    '''mutation DeleteComment(\$comment_id: String!) {
  delete_comments_by_pk(comment_id: \$comment_id) {
    __typename
  }
}
''';

Query reactToPostReq(
  String postID, {
  String? reaction,
}) {
  return Query(
    query: _reactToPostRawMutation,
    variables: <String, dynamic>{
      'postID': postID,
      'reaction': reaction,
    },
  );
}

// ---------- Reactions

// react to post

const _reactToPostRawMutation =
    '''mutation ReactToPost(\$postID: String!, \$reaction: String = "like") {
  reaction: insert_posts_reactions_one(object: {post_id: \$postID, reaction: \$reaction}) {
    reaction: reaction
  }
}
''';

Query unReactToPostReq(
  String postID,
) {
  return Query(
    query: _unReactToPostRawMutation,
    variables: <String, dynamic>{
      'postID': postID,
    },
  );
}

//  unreact to post

const _unReactToPostRawMutation = '''mutation UnReactToPost(\$postID: String!) {
  delete_posts_reactions(where: {post_id: {_eq: \$postID}}) {
    __typename
  }
}
''';

Query getLikedPostsReq(
  String uid,
  String? afterCreationTime,
  String? beforeCreationTime, {
  int? limit,
  String? creationTimeSortOrder,
  bool withCreatorProfile = true,
}) {
  return Query(
    query: _getLikedPostsRawQuery,
    variables: <String, dynamic>{
      'uid': uid,
      'afterCreationTime': afterCreationTime,
      'beforeCreationTime': beforeCreationTime,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
      'withCreatorProfile': withCreatorProfile,
    },
  );
}

// note: the post needs to be extracted

const _getLikedPostsRawQuery =
    '''query GetLikedPosts(\$uid: String!, \$afterCreationTime: timestamptz = null, \$beforeCreationTime: timestamptz = null, \$limit: Int = 10, \$creationTimeSortOrder: order_by = desc, \$withCreatorProfile: Boolean! = true) {
  likedPosts: posts_reactions(where: {uid: {_eq: \$uid}, created_at: {_gt: \$afterCreationTime, _lte: \$beforeCreationTime}}, limit: \$limit, order_by: {created_at: \$creationTimeSortOrder}) {
    post {
      ...Post
    }
  }
}
$_postRawFragment
''';

Query reactToCommentReq(
  String commentID, {
  String reaction = 'like',
}) {
  return Query(
    query: _reactToCommentRawMutation,
    variables: <String, dynamic>{
      'commentID': commentID,
      'reaction': reaction,
    },
  );
}

// react to comment

const _reactToCommentRawMutation =
    '''mutation ReactToComment(\$commentID: String!, \$reaction: String! = "like") {
  insert_comments_reactions_one(object: {comment_id: \$commentID, reaction: \$reaction}) {
    reaction : reaction
  }
}
''';

Query unReactToCommentReq(
  String commentID,
) {
  return Query(
    query: _unReactToCommentRawMutation,
    variables: <String, dynamic>{
      'commentID': commentID,
    },
  );
}

// unreact to comment

const _unReactToCommentRawMutation =
    '''mutation UnReactToComment(\$commentID: String!) {
  delete_comments_reactions(where: {comment_id: {_eq: \$commentID}}) {
    __typename
  }
}
''';

Query getLikedCommentsReq(
  String uid,
  String? afterCreationTime,
  String? beforeCreationTime, {
  int? limit,
  String? creationTimeSortOrder,
  bool withCreatorProfile = true,
  bool withPost = false,
}) {
  return Query(
    query: _getLikedCommentsRawQuery,
    variables: <String, dynamic>{
      'uid': uid,
      'afterCreationTime': afterCreationTime,
      'beforeCreationTime': beforeCreationTime,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
      'withCreatorProfile': withCreatorProfile,
      'withPost': withPost,
    },
  );
}

// note: the comment needs to be extracted

const _getLikedCommentsRawQuery =
    '''query GetLikedComments(\$uid: String!, \$afterCreationTime: timestamptz = null, \$beforeCreationTime: timestamptz = null, \$limit: Int = 10, \$creationTimeSortOrder: order_by = desc, \$withCreatorProfile: Boolean! = true, \$withPost: Boolean! = false) {
  likedComments: comments_reactions(where: {uid: {_eq: \$uid}, created_at: {_gt: \$afterCreationTime, _lte: \$beforeCreationTime}}, limit: \$limit, order_by: {created_at: \$creationTimeSortOrder}) {
    comment : comment {
      ...Comment
    }
  }
}
$_commentRawFragment
''';

Query sendMessageReq(
  String content,
  String receiverUid,
  String senderLocalMessageId,
  String? parentId,
) {
  return Query(
    query: _sendMessageRawMutation,
    variables: <String, dynamic>{
      'content': content,
      'receiver_uid': receiverUid,
      'sender_local_message_id': senderLocalMessageId,
      'parent_id': parentId,
    },
  );
}

// we only need the message_id for this task since all the other message component are available.

const _sendMessageRawMutation =
    '''mutation SendMessage(\$content: String!, \$receiver_uid: String!, \$sender_local_message_id: String!, \$parent_id: String = null,) {
  message : insert_messages_one(object: {content: \$content, receiver_uid: \$receiver_uid, sender_local_message_id: \$sender_local_message_id, parent_id: \$parent_id,}) {
    messageID : message_id
  }
}
''';

Query getForoByIDReq(
  String foroID,
) {
  return Query(
    query: _getForoByIDRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
    },
  );
}

// --------------------------------------------------------- QUERIES

const _getForoByIDRawQuery = '''query GetForoByID(\$foroID: String!) {
  foro: foros_by_pk(foro_id: \$foroID) {
		...Foro
  }
}
$_foroRawFragment
''';

Query getForosForExploreReq(
  String? category,
  int? limit, {
  String? creationTimeSortOrder,
}) {
  return Query(
    query: _getForosForExploreRawQuery,
    variables: <String, dynamic>{
      'category': category,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
    },
  );
}

// show foros where the user is not a member (note this is a top level function, not querying foros table directly)
// need to allow querying: newest, most users, most posts, ... etc.
// also, need to allow searching and further filtering by country, language, etc.

const _getForosForExploreRawQuery =
    '''query GetForosForExplore(\$category: String = null, \$limit: Int = null, \$creationTimeSortOrder: order_by = desc) {
  foros: get_foros_for_explore(limit: \$limit, where: {category: {_eq: \$category}}) {
    ...Foro
  }
}
$_foroRawFragment
''';

Query getJoinedForosReq(
  String uid,
  String? afterLastUpdatedTime,
  String? beforeLastUpdatedTime, {
  int? limit,
  String? lastUpdatedTimeSortOrder,
}) {
  return Query(
    query: _getJoinedForosRawQuery,
    variables: <String, dynamic>{
      'uid': uid,
      'afterLastUpdatedTime': afterLastUpdatedTime,
      'beforeLastUpdatedTime': beforeLastUpdatedTime,
      'limit': limit,
      'lastUpdatedTimeSortOrder': lastUpdatedTimeSortOrder,
    },
  );
}

// alternative approach for ForosExplore:
// Instead of a top level function, query the foros table and filter by `user_role` == null. `user_role` is a computed field on foros table.
// query getForosForExplore($limit: Int = 50, $afterLastUpdatedTime: timestamptz = null, $beforeLastUpdatedTime: timestamptz = null, $lastUpdatedTimeSortOrder: order_by = desc, $_neq: String = "uid") {
//   foros: foros(limit: $limit, where: {user_role: {_is_null: true}, updated_at: {_gte: $afterLastUpdatedTime, _lte: $beforeLastUpdatedTime}}, order_by: {updated_at: $lastUpdatedTimeSortOrder}) {
//     ...Foro
//   }
// }

// note: here we are filtering by `memberships` and not by `user_membership` since the latter is a computed field for the user making the request only

const _getJoinedForosRawQuery =
    '''query GetJoinedForos(\$uid: String!, \$limit: Int = 50, \$afterLastUpdatedTime: timestamptz = null, \$beforeLastUpdatedTime: timestamptz = null, \$lastUpdatedTimeSortOrder: order_by = desc) {
  foros: foros(limit: \$limit, where: {memberships: {uid: {_eq: \$uid}}, updated_at: {_gte: \$afterLastUpdatedTime, _lte: \$beforeLastUpdatedTime}}, order_by: {updated_at: \$lastUpdatedTimeSortOrder}) {
    ...Foro
  }
}
$_foroRawFragment
''';

Query joinedForosStreamReq(
  String uid,
  String? afterLastUpdatedTime,
  String? beforeLastUpdatedTime, {
  int? limit,
  String? lastUpdatedTimeSortOrder,
}) {
  return Query(
    query: _joinedForosStreamRawSubscription,
    variables: <String, dynamic>{
      'uid': uid,
      'afterLastUpdatedTime': afterLastUpdatedTime,
      'beforeLastUpdatedTime': beforeLastUpdatedTime,
      'limit': limit,
      'lastUpdatedTimeSortOrder': lastUpdatedTimeSortOrder,
    },
  );
}

const _joinedForosStreamRawSubscription =
    '''subscription JoinedForosStream(\$uid: String!, \$limit: Int = 50, \$afterLastUpdatedTime: timestamptz = null, \$beforeLastUpdatedTime: timestamptz = null, \$lastUpdatedTimeSortOrder: order_by = desc) {
  foros: foros(limit: \$limit, where: {memberships: {uid: {_eq: \$uid}}, updated_at: {_gte: \$afterLastUpdatedTime, _lte: \$beforeLastUpdatedTime}}, order_by: {updated_at: \$lastUpdatedTimeSortOrder}) {
    ...Foro
  }
}
$_foroRawFragment
''';

Query getForoMembersReq(
  String foroID,
  String? afterJoinedAtDate,
  List<String>? roles,
) {
  return Query(
    query: _getForoMembersRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'afterJoinedAtDate': afterJoinedAtDate,
      'roles': roles,
    },
  );
}

const _getForoMembersRawQuery =
    '''query GetForoMembers(\$foroID: String!, \$afterJoinedAtDate: timestamptz = null, \$roles: [String!]!) {
  memberships: memberships(where: {foro_id: {_eq: \$foroID}, joined_at: {_gte: \$afterJoinedAtDate}, role: {_in: \$roles}}, order_by: {joined_at: asc}) {
    membershipID: membership_id
    uid: uid
    foroID: foro_id
    role: role
    joinedAt: joined_at
    profile: user {
      ...Profile
    }
  }
}
$_profileRawFragment
''';

Query getConversationsReq(
  String? afterLastUpdatedTime,
  String? beforeLastUpdatedTime,
  int? limit, {
  String? lastUpdatedTimeSortOrder,
}) {
  return Query(
    query: _getConversationsRawQuery,
    variables: <String, dynamic>{
      'afterLastUpdatedTime': afterLastUpdatedTime,
      'beforeLastUpdatedTime': beforeLastUpdatedTime,
      'limit': limit,
      'lastUpdatedTimeSortOrder': lastUpdatedTimeSortOrder,
    },
  );
}

// -------- Convos and Messages

// get conversations

const _getConversationsRawQuery =
    '''query GetConversations(\$afterLastUpdatedTime: timestamptz = null, \$beforeLastUpdatedTime: timestamptz = null, \$limit: Int = null, \$lastUpdatedTimeSortOrder: order_by = desc) {
  conversations: inbox_view(where: {last_updated_time: {_gt: \$afterLastUpdatedTime, _lte: \$beforeLastUpdatedTime}}, limit: \$limit, order_by: {last_updated_time: \$lastUpdatedTimeSortOrder},) {
    ...Convo
  }
}
$_convoRawFragment
''';

Query conversationsStreamReq(
  String? afterLastUpdatedTime,
  String? beforeLastUpdatedTime,
  int? limit, {
  String? lastUpdatedTimeSortOrder,
}) {
  return Query(
    query: _conversationsStreamRawSubscription,
    variables: <String, dynamic>{
      'afterLastUpdatedTime': afterLastUpdatedTime,
      'beforeLastUpdatedTime': beforeLastUpdatedTime,
      'limit': limit,
      'lastUpdatedTimeSortOrder': lastUpdatedTimeSortOrder,
    },
  );
}

const _conversationsStreamRawSubscription =
    '''subscription ConversationsStream(\$afterLastUpdatedTime: timestamptz = null, \$beforeLastUpdatedTime: timestamptz = null, \$limit: Int = null, \$lastUpdatedTimeSortOrder: order_by = desc) {
  conversations: inbox_view(where: {last_updated_time: {_gt: \$afterLastUpdatedTime, _lte: \$beforeLastUpdatedTime}}, limit: \$limit, order_by: {last_updated_time: \$lastUpdatedTimeSortOrder},) {
    ...Convo
  }
}
$_convoRawFragment
''';

Query getMessagesReq(
  String otherUid,
  String? afterCreationTime,
  String? beforeCreationTime,
  int? limit, {
  String? creationTimeSortOrder,
}) {
  return Query(
    query: _getMessagesRawQuery,
    variables: <String, dynamic>{
      'other_uid': otherUid,
      'afterCreationTime': afterCreationTime,
      'beforeCreationTime': beforeCreationTime,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
    },
  );
}

// TODO: remove sort order in messages_view in the database since it's redundant.

const _getMessagesRawQuery =
    '''query GetMessages(\$other_uid: String!, \$afterCreationTime: timestamptz = null, \$beforeCreationTime: timestamptz = null, \$limit: Int = null, \$creationTimeSortOrder: order_by = desc) {
  messages: messages_view(where: {created_at: {_gt: \$afterCreationTime, _lt: \$beforeCreationTime}, other_uid: {_eq: \$other_uid}}, limit: \$limit, order_by: {created_at: \$creationTimeSortOrder}) {
    ...Message
  }
}
$_messageRawFragment
''';

Query messagesStreamReq(
  String otherUid,
  String? afterCreationTime,
  String? beforeCreationTime,
  int? limit, {
  String? creationTimeSortOrder,
}) {
  return Query(
    query: _messagesStreamRawSubscription,
    variables: <String, dynamic>{
      'other_uid': otherUid,
      'afterCreationTime': afterCreationTime,
      'beforeCreationTime': beforeCreationTime,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
    },
  );
}

const _messagesStreamRawSubscription =
    '''subscription MessagesStream(\$other_uid: String!, \$afterCreationTime: timestamptz = null, \$beforeCreationTime: timestamptz = null, \$limit: Int = null, \$creationTimeSortOrder: order_by = desc) {
  messages: messages_view(where: {created_at: {_gt: \$afterCreationTime, _lt: \$beforeCreationTime}, other_uid: {_eq: \$other_uid}}, limit: \$limit, order_by: {created_at: \$creationTimeSortOrder}) {
    ...Message
  }
}
$_messageRawFragment
''';

Query markConversationAsReadReq(
  String otherUid,
) {
  return Query(
    query: _markConversationAsReadRawMutation,
    variables: <String, dynamic>{
      'other_uid': otherUid,
    },
  );
}

const _markConversationAsReadRawMutation =
    '''mutation MarkConversationAsRead(\$other_uid: String!) {
  update_messages_status(where: {other_uid: {_eq: \$other_uid}, is_read: {_eq: false}}, _set: {is_read: true, is_seen: true}) {
    __typename
  }
}
''';

Query markInboxAsSeenReq() {
  return Query(
    query: _markInboxAsSeenRawMutation,
    variables: <String, dynamic>{},
  );
}

// we could make this nullable to mark all messages as seen for the specific user

const _markInboxAsSeenRawMutation = '''mutation MarkInboxAsSeen {
  update_messages_status(where: {is_seen: {_eq: false}}, _set: {is_seen: true}) {
    __typename
  }
}
''';

Query deleteMessageReq(
  String messageId,
) {
  return Query(
    query: _deleteMessageRawMutation,
    variables: <String, dynamic>{
      'message_id': messageId,
    },
  );
}

// this will mark message status as deleted for the current user only (using x-hasura-user-id)

const _deleteMessageRawMutation =
    '''mutation DeleteMessage(\$message_id: String!) {
  update_messages_status(where: {message_id: {_eq: \$message_id}}, _set: {is_deleted: true}) {
    __typename
  }
}
''';

Query unseenMessagesCountReq() {
  return Query(
    query: _unseenMessagesCountRawSubscription,
    variables: <String, dynamic>{},
  );
}

const _unseenMessagesCountRawSubscription =
    '''subscription UnseenMessagesCount {
  aggFun : messages_status_aggregate(where: {is_seen: {_eq: false}}) {
    aggObj: aggregate {
      count : count
    }
  }
}
''';

Query getForoPostsReq(
  String foroID,
  String? afterCreationTime,
  String? beforeCreationTime,
  int? limit, {
  String? creationTimeSortOrder,
  bool withCreatorProfile = true,
}) {
  return Query(
    query: _getForoPostsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'afterCreationTime': afterCreationTime,
      'beforeCreationTime': beforeCreationTime,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
      'withCreatorProfile': withCreatorProfile,
    },
  );
}

// -------- Posts

const _getForoPostsRawQuery =
    '''query GetForoPosts(\$foroID: String!, \$afterCreationTime: timestamptz = null, \$beforeCreationTime: timestamptz = null, \$creationTimeSortOrder: order_by = desc, \$limit: Int = null,  \$withCreatorProfile: Boolean! = true) {
  posts: posts(where: {foro_id: {_eq: \$foroID}, created_at: {_gt: \$afterCreationTime, _lt: \$beforeCreationTime}}, order_by: {created_at: \$creationTimeSortOrder}, limit: \$limit) {
    ...Post
  }
}
$_postRawFragment
''';

Query foroPostsStreamReq(
  String foroID,
  String? afterCreationTime,
  String? beforeCreationTime,
  int? limit, {
  String? creationTimeSortOrder,
  bool withCreatorProfile = true,
}) {
  return Query(
    query: _foroPostsStreamRawSubscription,
    variables: <String, dynamic>{
      'foroID': foroID,
      'afterCreationTime': afterCreationTime,
      'beforeCreationTime': beforeCreationTime,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
      'withCreatorProfile': withCreatorProfile,
    },
  );
}

const _foroPostsStreamRawSubscription =
    '''subscription foroPostsStream(\$foroID: String!, \$afterCreationTime: timestamptz = null, \$beforeCreationTime: timestamptz = null, \$creationTimeSortOrder: order_by = desc, \$limit: Int = null,  \$withCreatorProfile: Boolean! = true) {
  posts: posts(where: {foro_id: {_eq: \$foroID}, created_at: {_gt: \$afterCreationTime, _lt: \$beforeCreationTime}}, order_by: {created_at: \$creationTimeSortOrder}, limit: \$limit) {
    ...Post
  }
}
$_postRawFragment
''';

Query getMostLikedPostsReq(
  String foroID,
  int? limit, {
  bool withCreatorProfile = true,
}) {
  return Query(
    query: _getMostLikedPostsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'limit': limit,
      'withCreatorProfile': withCreatorProfile,
    },
  );
}

const _getMostLikedPostsRawQuery =
    '''query GetMostLikedPosts(\$foroID: String!, \$limit: Int = null,  \$withCreatorProfile: Boolean! = true) {
  posts: posts(where: {foro_id: {_eq: \$foroID}}, order_by: {reactions_count: desc}, limit: \$limit) {
    ...Post
  }
}
$_postRawFragment
''';

Query getMostCommentedPotsReq(
  String foroID,
  int? limit, {
  bool withCreatorProfile = true,
}) {
  return Query(
    query: _getMostCommentedPotsRawQuery,
    variables: <String, dynamic>{
      'foroID': foroID,
      'limit': limit,
      'withCreatorProfile': withCreatorProfile,
    },
  );
}

const _getMostCommentedPotsRawQuery =
    '''query GetMostCommentedPots(\$foroID: String!, \$limit: Int = null, \$withCreatorProfile: Boolean! = true ) {
  posts: posts(where: {foro_id: {_eq: \$foroID}}, order_by: {comments_count: desc}, limit: \$limit) {
    ...Post
  }
}
$_postRawFragment
''';

Query getPostByIDReq(
  String postID, {
  bool withCreatorProfile = false,
}) {
  return Query(
    query: _getPostByIDRawQuery,
    variables: <String, dynamic>{
      'postID': postID,
      'withCreatorProfile': withCreatorProfile,
    },
  );
}

const _getPostByIDRawQuery =
    '''query GetPostByID(\$postID: String!, \$withCreatorProfile: Boolean! = false) {
  post : posts_by_pk(post_id: \$postID) {
    ...Post
  }
}
$_postRawFragment
''';

Query getUserPostsReq(
  String uid,
  String? afterCreationTime,
  String? beforeCreationTime,
  int? limit, {
  String? creationTimeSortOrder,
  bool withCreatorProfile = false,
}) {
  return Query(
    query: _getUserPostsRawQuery,
    variables: <String, dynamic>{
      'uid': uid,
      'afterCreationTime': afterCreationTime,
      'beforeCreationTime': beforeCreationTime,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
      'withCreatorProfile': withCreatorProfile,
    },
  );
}

const _getUserPostsRawQuery =
    '''query GetUserPosts(\$uid: String!, \$afterCreationTime: timestamptz = null, \$beforeCreationTime: timestamptz = null, \$creationTimeSortOrder: order_by = desc, \$limit: Int = null,  \$withCreatorProfile: Boolean! = false) {
  posts: posts(where: {created_by: {_eq: \$uid}, created_at: {_gt: \$afterCreationTime, _lt: \$beforeCreationTime}}, order_by: {created_at: \$creationTimeSortOrder}, limit: \$limit) {
    ...Post
  }
}
$_postRawFragment
''';

Query getPostCommentsReq(
  String postID,
  String? afterCreationTime,
  String? beforeCreationTime,
  int? limit, {
  String? creationTimeSortOrder,
  bool withCreatorProfile = true,
  bool withPost = false,
}) {
  return Query(
    query: _getPostCommentsRawQuery,
    variables: <String, dynamic>{
      'postID': postID,
      'afterCreationTime': afterCreationTime,
      'beforeCreationTime': beforeCreationTime,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
      'withCreatorProfile': withCreatorProfile,
      'withPost': withPost,
    },
  );
}

// -------- comments

const _getPostCommentsRawQuery =
    '''query GetPostComments(\$postID: String!, \$afterCreationTime: timestamptz = null, \$beforeCreationTime: timestamptz = null, \$creationTimeSortOrder: order_by = desc, \$limit: Int = null, \$withCreatorProfile: Boolean! = true, \$withPost: Boolean! = false) {
  comments: comments(where: {post_id: {_eq: \$postID}, created_at: {_gt: \$afterCreationTime, _lt: \$beforeCreationTime}}, order_by: {created_at: \$creationTimeSortOrder}, limit: \$limit) {
    ...Comment
  }
}
$_commentRawFragment
''';

Query postCommentsStreamReq(
  String postID,
  String? afterCreationTime,
  String? beforeCreationTime,
  int? limit, {
  String? creationTimeSortOrder,
  bool withCreatorProfile = true,
  bool withPost = false,
}) {
  return Query(
    query: _postCommentsStreamRawSubscription,
    variables: <String, dynamic>{
      'postID': postID,
      'afterCreationTime': afterCreationTime,
      'beforeCreationTime': beforeCreationTime,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
      'withCreatorProfile': withCreatorProfile,
      'withPost': withPost,
    },
  );
}

const _postCommentsStreamRawSubscription =
    '''subscription PostCommentsStream(\$postID: String!, \$afterCreationTime: timestamptz = null, \$beforeCreationTime: timestamptz = null, \$creationTimeSortOrder: order_by = desc, \$limit: Int = null, \$withCreatorProfile: Boolean! = true, \$withPost: Boolean! = false) {
  comments: comments(where: {post_id: {_eq: \$postID}, created_at: {_gt: \$afterCreationTime, _lt: \$beforeCreationTime}}, order_by: {created_at: \$creationTimeSortOrder}, limit: \$limit) {
    ...Comment
  }
}
$_commentRawFragment
''';

Query getCommentByIDReq(
  String commentID, {
  bool withCreatorProfile = true,
  bool withPost = false,
}) {
  return Query(
    query: _getCommentByIDRawQuery,
    variables: <String, dynamic>{
      'commentID': commentID,
      'withCreatorProfile': withCreatorProfile,
      'withPost': withPost,
    },
  );
}

const _getCommentByIDRawQuery =
    '''query GetCommentByID(\$commentID: String!, \$withCreatorProfile: Boolean! = true, \$withPost: Boolean! = false) {
   comment: comments_by_pk(comment_id: \$commentID) {
    ...Comment
  }
}
$_commentRawFragment
''';

Query getUserCommentsReq(
  String uid,
  String? afterCreationTime,
  String? beforeCreationTime,
  int? limit, {
  String? creationTimeSortOrder,
  bool withCreatorProfile = true,
  bool withPost = false,
}) {
  return Query(
    query: _getUserCommentsRawQuery,
    variables: <String, dynamic>{
      'uid': uid,
      'afterCreationTime': afterCreationTime,
      'beforeCreationTime': beforeCreationTime,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
      'withCreatorProfile': withCreatorProfile,
      'withPost': withPost,
    },
  );
}

// the post and profile are useful here since all can be shown in the same place (user comments tab on the profile)

const _getUserCommentsRawQuery =
    '''query GetUserComments(\$uid: String!, \$afterCreationTime: timestamptz = null, \$beforeCreationTime: timestamptz = null, \$creationTimeSortOrder: order_by = desc, \$limit: Int = null, \$withCreatorProfile: Boolean! = true, \$withPost: Boolean! = false) {
  comments: comments(where: {created_by: {_eq: \$uid}, created_at: {_gt: \$afterCreationTime, _lt: \$beforeCreationTime}}, order_by: {created_at: \$creationTimeSortOrder}, limit: \$limit) {
    ...Comment
  }
}
$_commentRawFragment
''';

Query createUserProfileReq(
  String displayName,
  String photoUrl,
) {
  return Query(
    query: _createUserProfileRawMutation,
    variables: <String, dynamic>{
      'display_name': displayName,
      'photo_url': photoUrl,
    },
  );
}

// ---------- Profile

const _createUserProfileRawMutation =
    '''mutation CreateUserProfile(\$display_name: String!, \$photo_url: String!) {
  profile: insert_users(objects: {display_name: \$display_name, photo_url: \$photo_url}, on_conflict: {constraint: users_pkey, update_columns: [display_name, photo_url]}) {
    __typename
  }
}
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

const _getUserProfileRawQuery = '''query GetUserProfile(\$uid: String!) {
  profile : users_by_pk(uid: \$uid) {
   ...Profile
  }
}
$_profileRawFragment
''';

Query getNotificationsReq(
  String? afterCreationTime,
  String? beforeCreationTime,
  int? limit, {
  String? creationTimeSortOrder,
}) {
  return Query(
    query: _getNotificationsRawQuery,
    variables: <String, dynamic>{
      'afterCreationTime': afterCreationTime,
      'beforeCreationTime': beforeCreationTime,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
    },
  );
}

// -------- Notifications

const _getNotificationsRawQuery =
    '''query GetNotifications(\$afterCreationTime: timestamptz = null, \$beforeCreationTime: timestamptz = null, \$limit: Int = null,  \$creationTimeSortOrder: order_by = desc) {
  notifications: notifications(where: {created_at: {_gt: \$afterCreationTime, _lt: \$beforeCreationTime}}, order_by: {created_at: \$creationTimeSortOrder}, limit: \$limit) {
    ...Notification
  }
}
$_notificationRawFragment
''';

Query markNotificationAsReadReq(
  String notificationId,
) {
  return Query(
    query: _markNotificationAsReadRawMutation,
    variables: <String, dynamic>{
      'notification_id': notificationId,
    },
  );
}

const _markNotificationAsReadRawMutation =
    '''mutation MarkNotificationAsRead(\$notification_id: String!) {
  update_notifications(where: {notification_id: {_eq: \$notification_id}, is_read: {_eq: false}}, _set: {is_read: true}) {
    __typename
  }
}
''';

Query markNotificationsAsSeenReq() {
  return Query(
    query: _markNotificationsAsSeenRawMutation,
    variables: <String, dynamic>{},
  );
}

const _markNotificationsAsSeenRawMutation =
    '''mutation MarkNotificationsAsSeen {
  update_notifications(where: {is_seen: {_eq: false}}, _set: {is_seen: true}) {
    __typename
  }
}
''';

Query deleteNotificationReq(
  String notificationId,
) {
  return Query(
    query: _deleteNotificationRawMutation,
    variables: <String, dynamic>{
      'notification_id': notificationId,
    },
  );
}

const _deleteNotificationRawMutation =
    '''mutation DeleteNotification(\$notification_id: String!) {
  update_notifications(where: {notification_id: {_eq: \$notification_id}}, _set: {is_deleted: true}) {
    __typename
  }
}
''';

Query unseenNotificationsCountReq() {
  return Query(
    query: _unseenNotificationsCountRawSubscription,
    variables: <String, dynamic>{},
  );
}

const _unseenNotificationsCountRawSubscription =
    '''subscription UnseenNotificationsCount {
  aggFun : notifications_aggregate(where: {is_seen: {_eq: false}}) {
    aggObj : aggregate {
      count : count
    }
  }
}
''';

Query notificationsStreamReq(
  String? afterCreationTime,
  String? beforeCreationTime,
  int? limit, {
  String? creationTimeSortOrder,
}) {
  return Query(
    query: _notificationsStreamRawSubscription,
    variables: <String, dynamic>{
      'afterCreationTime': afterCreationTime,
      'beforeCreationTime': beforeCreationTime,
      'limit': limit,
      'creationTimeSortOrder': creationTimeSortOrder,
    },
  );
}

const _notificationsStreamRawSubscription =
    '''subscription NotificationsStream(\$afterCreationTime: timestamptz = null, \$beforeCreationTime: timestamptz = null, \$limit: Int = null, \$creationTimeSortOrder: order_by = desc) {
  notifications: notifications(where: {created_at: {_gt: \$afterCreationTime, _lt: \$beforeCreationTime}}, limit: \$limit, order_by: {created_at: \$creationTimeSortOrder}) {
    ...Notification
  }
}
$_notificationRawFragment
''';

Query addForoVisitReq(
  String foroId, {
  String? visitedFrom,
}) {
  return Query(
    query: _addForoVisitRawMutation,
    variables: <String, dynamic>{
      'foro_id': foroId,
      'visited_from': visitedFrom,
    },
  );
}

const _addForoVisitRawMutation =
    '''mutation AddForoVisit(\$foro_id: String!, \$visited_from: String = "") {
  insert_foro_visits_one(object: {foro_id: \$foro_id, visited_from: \$visited_from}, on_conflict: {constraint: foro_visits_pkey, update_columns: [visited_from]}) {
    __typename
  }
}
''';

Query addPostVisitReq(
  String postId, {
  String? visitedFrom,
}) {
  return Query(
    query: _addPostVisitRawMutation,
    variables: <String, dynamic>{
      'post_id': postId,
      'visited_from': visitedFrom,
    },
  );
}

const _addPostVisitRawMutation =
    '''mutation AddPostVisit(\$post_id: String!, \$visited_from: String = "") {
  insert_post_visits_one(object: {post_id: \$post_id, visited_from: \$visited_from}, on_conflict: {constraint: post_visits_pkey, update_columns: [visited_from]}) {
    __typename
  }
}
''';

Query getVisitedPostsReq(
  String? afterVisitedTime,
  String? beforeVisitedTime, {
  int? limit,
  String? visitedTimeSortOrder,
  bool withCreatorProfile = true,
}) {
  return Query(
    query: _getVisitedPostsRawQuery,
    variables: <String, dynamic>{
      'afterVisitedTime': afterVisitedTime,
      'beforeVisitedTime': beforeVisitedTime,
      'limit': limit,
      'visitedTimeSortOrder': visitedTimeSortOrder,
      'withCreatorProfile': withCreatorProfile,
    },
  );
}

const _getVisitedPostsRawQuery =
    '''query GetVisitedPosts(\$afterVisitedTime: timestamptz = null, \$beforeVisitedTime: timestamptz = null, \$limit: Int = 10, \$visitedTimeSortOrder: order_by = desc, \$withCreatorProfile: Boolean! = true) {
  visitedPosts: post_visits(where: {visited_at: {_gt: \$afterVisitedTime, _lte: \$beforeVisitedTime}}, limit: \$limit, order_by: {visited_at: \$visitedTimeSortOrder}) {
    post: post {
      ...Post
    }
  }
}
$_postRawFragment
''';
