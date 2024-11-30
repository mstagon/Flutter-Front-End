import 'package:dimple/common/const/theme.dart';
import 'package:dimple/chatbot/view/data.dart';
import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {

  AppTheme theme = LightTheme();
  bool isDarkTheme = false;
  final _chatController = ChatController(
    initialMessageList: Data.messageList,
    scrollController: ScrollController(),
    currentUser: ChatUser(
      id: '1',
      name: 'Flutter',
      profilePhoto: Data.profileImage,
    ),
    otherUsers: [
      ChatUser(
        id: '2',
        name: 'BanreouChat',
        profilePhoto: Data.profileImage,
      ),
    ],
  );

  void _showHideTypingIndicator() {
    _chatController.setTypingIndicator = !_chatController.showTypingIndicator;
  }

  void receiveMessage() async {
    _chatController.addMessage(
      Message(
        id: DateTime.now().toString(),
        message: '테스트 중입니다.',
        createdAt: DateTime.now(),
        sentBy: '2',

      ),
    );
    // await Future.delayed(const Duration(milliseconds: 500));
    // _chatController.addReplySuggestions([
    //   const SuggestionItemData(text: 'Thanks.'),
    //   const SuggestionItemData(text: 'Thank you very much.'),
    //   const SuggestionItemData(text: 'Great.')
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: theme.appBarColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/img/banreou.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Dimple과 대화기록',
                      style: TextStyle(
                        color: theme.appBarTitleTextStyle,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context,index){
                return ListTile(
                  leading: Icon(Icons.chat),
                  title: Text('$index 대화기록 입니다.'),
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                );

              },
                itemCount: 10,
              )
            ],
          ),
        ),
        body: ChatView(
          chatController: _chatController,
          onSendTap: _onSendTap,
          featureActiveConfig: FeatureActiveConfig(
            lastSeenAgoBuilderVisibility: true,
            receiptsBuilderVisibility: true,
            enableScrollToBottomButton: true,
            enableSwipeToSeeTime: true,
          ),
          scrollToBottomButtonConfig: ScrollToBottomButtonConfig(
            backgroundColor: theme.textFieldBackgroundColor,
            border: Border.all(
              color: isDarkTheme ? Colors.transparent : Colors.grey,
            ),
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: theme.themeIconColor,
              weight: 10,
              size: 30,
            ),
          ),
          chatViewState: ChatViewState.hasMessages,
          chatViewStateConfig: ChatViewStateConfiguration(
            loadingWidgetConfig: ChatViewStateWidgetConfiguration(
              loadingIndicatorColor: theme.outgoingChatBubbleColor,
            ),
            onReloadButtonTap: () {},
          ),
          typeIndicatorConfig: TypeIndicatorConfiguration(
            flashingCircleBrightColor: theme.flashingCircleBrightColor,
            flashingCircleDarkColor: theme.flashingCircleDarkColor,
          ),
          appBar: ChatViewAppBar(
            elevation: theme.elevation,
            backGroundColor: theme.appBarColor,
            // profilePicture: Data.profileImage,
            backArrowColor: theme.backArrowColor,
            chatTitle: "Chat view",
            chatTitleTextStyle: TextStyle(
              color: theme.appBarTitleTextStyle,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.25,
            ),
            // 나중에 소셜 채팅에서 이용 가능할것같은 기능
            // userStatus: "online",
            // userStatusTextStyle: const TextStyle(color: Colors.grey),
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.menu,
                  color: theme.themeIconColor,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            actions: [
              IconButton(
                onPressed: _onThemeIconTap,
                icon: Icon(
                  isDarkTheme
                      ? Icons.brightness_4_outlined
                      : Icons.dark_mode_outlined,
                  color: theme.themeIconColor,
                ),
              ),
              // IconButton(
              //   tooltip: 'Toggle TypingIndicator',
              //   onPressed: _showHideTypingIndicator,
              //   icon: Icon(
              //     Icons.keyboard,
              //     color: theme.themeIconColor,
              //   ),
              // ),
              IconButton(
                tooltip: '메시지 수신',
                onPressed: receiveMessage,
                icon: Icon(
                  Icons.supervised_user_circle,
                  color: theme.themeIconColor,
                ),
              ),
            ],
          ),
          chatBackgroundConfig: ChatBackgroundConfiguration(
            messageTimeIconColor: theme.messageTimeIconColor,
            messageTimeTextStyle: TextStyle(color: theme.messageTimeTextColor),
            defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
              textStyle: TextStyle(
                color: theme.chatHeaderColor,
                fontSize: 17,
              ),
            ),
            backgroundColor: theme.backgroundColor,
          ),
          sendMessageConfig: SendMessageConfiguration(
            imagePickerIconsConfig: ImagePickerIconsConfiguration(
              cameraIconColor: theme.cameraIconColor,
              galleryIconColor: theme.galleryIconColor,
            ),
            replyMessageColor: theme.replyMessageColor,
            defaultSendButtonColor: theme.sendButtonColor,
            replyDialogColor: theme.replyDialogColor,
            replyTitleColor: theme.replyTitleColor,
            textFieldBackgroundColor: theme.textFieldBackgroundColor,
            closeIconColor: theme.closeIconColor,
            textFieldConfig: TextFieldConfiguration(
              onMessageTyping: (status) {
                debugPrint(status.toString());
              },
              compositionThresholdTime: const Duration(seconds: 1),
              textStyle: TextStyle(color: theme.textFieldTextColor),
            ),
            micIconColor: theme.replyMicIconColor,
            voiceRecordingConfiguration: VoiceRecordingConfiguration(
              backgroundColor: theme.waveformBackgroundColor,
              recorderIconColor: theme.recordIconColor,
              waveStyle: WaveStyle(
                showMiddleLine: false,
                waveColor: theme.waveColor ?? Colors.white,
                extendWaveform: true,
              ),
            ),
            cancelRecordConfiguration: CancelRecordConfiguration(
              icon: Icon(Icons.cancel),
            ),
          ),
          chatBubbleConfig: ChatBubbleConfiguration(
            outgoingChatBubbleConfig: ChatBubble(
              linkPreviewConfig: LinkPreviewConfiguration(
                backgroundColor: theme.linkPreviewOutgoingChatColor,
                bodyStyle: theme.outgoingChatLinkBodyStyle,
                titleStyle: theme.outgoingChatLinkTitleStyle,
              ),
              receiptsWidgetConfig:
              const ReceiptsWidgetConfig(showReceiptsIn: ShowReceiptsIn.lastMessage),
              color: theme.outgoingChatBubbleColor,
            ),
            inComingChatBubbleConfig: ChatBubble(
              linkPreviewConfig: LinkPreviewConfiguration(
                linkStyle: TextStyle(
                  color: theme.inComingChatBubbleTextColor,
                  decoration: TextDecoration.underline,
                ),
                backgroundColor: theme.linkPreviewIncomingChatColor,
                bodyStyle: theme.incomingChatLinkBodyStyle,
                titleStyle: theme.incomingChatLinkTitleStyle,
              ),
              textStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
              // onMessageRead: (message) {
              //   debugPrint('Message Read');
              // },
              senderNameTextStyle:
              TextStyle(color: theme.inComingChatBubbleTextColor),
              color: theme.inComingChatBubbleColor,
            ),
          ),
          replyPopupConfig: ReplyPopupConfiguration(
            backgroundColor: theme.replyPopupColor,
            buttonTextStyle: TextStyle(color: theme.replyPopupButtonColor),
            topBorderColor: theme.replyPopupTopBorderColor,
          ),
          reactionPopupConfig: ReactionPopupConfiguration(
            shadow: BoxShadow(
              color: isDarkTheme ? Colors.black54 : Colors.grey.shade400,
              blurRadius: 20,
            ),
            backgroundColor: theme.reactionPopupColor,
          ),
          messageConfig: MessageConfiguration(
            messageReactionConfig: MessageReactionConfiguration(
              backgroundColor: theme.messageReactionBackGroundColor,
              borderColor: theme.messageReactionBackGroundColor,
              reactedUserCountTextStyle:
              TextStyle(color: theme.inComingChatBubbleTextColor),
              reactionCountTextStyle:
              TextStyle(color: Colors.red),
              reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
                backgroundColor: theme.backgroundColor,
                reactedUserTextStyle: TextStyle(
                  color: theme.inComingChatBubbleTextColor,
                ),
                reactionWidgetDecoration: BoxDecoration(
                  color: theme.inComingChatBubbleColor,
                  boxShadow: [
                    BoxShadow(
                      color: isDarkTheme ? Colors.black12 : Colors.grey.shade200,
                      offset: const Offset(0, 20),
                      blurRadius: 40,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            imageMessageConfig: ImageMessageConfiguration(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              shareIconConfig: ShareIconConfiguration(
                defaultIconBackgroundColor: theme.shareIconBackgroundColor,
                defaultIconColor: theme.shareIconColor,
              ),
            ),
          ),
          profileCircleConfig: const ProfileCircleConfiguration(
            profileImageUrl: Data.profileImage,
          ),
          repliedMessageConfig: RepliedMessageConfiguration(
            backgroundColor: theme.repliedMessageColor,
            verticalBarColor: theme.verticalBarColor,
            repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
              enableHighlightRepliedMsg: true,
              highlightColor: Colors.pinkAccent.shade100,
              highlightScale: 1.1,
            ),
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.25,
            ),
            replyTitleTextStyle: TextStyle(color: theme.repliedTitleTextColor),
          ),
          swipeToReplyConfig: SwipeToReplyConfiguration(
            replyIconColor: theme.swipeToReplyIconColor,
          ),
          replySuggestionsConfig: ReplySuggestionsConfig(
            itemConfig: SuggestionItemConfig(
              decoration: BoxDecoration(
                color: theme.textFieldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.outgoingChatBubbleColor ?? Colors.white,
                ),
              ),
              textStyle: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            onTap: (item) => _onSendTap(item.text, const ReplyMessage(), MessageType.text),
          ),
        ),
      ),
    );
  }

  void _onSendTap(
      String message,
      ReplyMessage replyMessage,
      MessageType messageType,
      ) {
    _chatController.addMessage(
      Message(
        id: DateTime.now().toString(),
        createdAt: DateTime.now(),
        message: message,
        sentBy: _chatController.currentUser.id,
        replyMessage: replyMessage,
        messageType: messageType,
      ),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      _chatController.initialMessageList.last.setStatus =
          MessageStatus.undelivered;
    });
    // 읽음처리
    // Future.delayed(const Duration(seconds: 1), () {
    //   _chatController.initialMessageList.last.setStatus = MessageStatus.read;
    // });
  }

  void _onThemeIconTap() {
    setState(() {
      if (isDarkTheme) {
        theme = LightTheme();
        isDarkTheme = false;
      } else {
        theme = DarkTheme();
        isDarkTheme = true;
      }
    });
  }
}