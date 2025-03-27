//
//  YTM+parser.swift
//  YouTubeMusicKit
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
// typealias Root = [RootElement]
protocol ParseObjects: Codable{}
struct Root: SearchResultType {
    let contents: [Contents]
}
// MARK: - WelcomeElement
struct Contents: ParseObjects {
    let itemSectionRenderer: ItemSectionRenderer?
    let musicCardShelfRenderer: MusicCardShelfRenderer?
    let musicShelfRenderer: MusicShelfRenderer?
}

// MARK: - ItemSectionRenderer
struct ItemSectionRenderer: ParseObjects {
    let trackingParams: String?
    let contents: [ItemSectionRendererContent]?
}

// MARK: - ItemSectionRendererContent
struct ItemSectionRendererContent: ParseObjects {
    let messageRenderer: PurpleMessageRenderer?
}

// MARK: - PurpleMessageRenderer
struct PurpleMessageRenderer: ParseObjects {
    let button: MessageRendererButton?
    let style: StyleClass?
    let trackingParams: String?
}

// MARK: - MessageRendererButton
struct MessageRendererButton: ParseObjects {
    let buttonRenderer: PurpleButtonRenderer?
}

// MARK: - PurpleButtonRenderer
struct PurpleButtonRenderer: Codable {
    let navigationEndpoint: PurpleNavigationEndpoint?
    let style, iconPosition: String?
    let text: ButtonRendererText?
    let isDisabled: Bool?
    let trackingParams: String?
    let icon: Icon?
}

// MARK: - Icon
struct Icon: Codable {
    let iconType: String?
}

// MARK: - PurpleNavigationEndpoint
struct PurpleNavigationEndpoint: Codable {
    let clickTrackingParams: String?
    let urlEndpoint: URLEndpoint?
}

// MARK: - URLEndpoint
struct URLEndpoint: Codable {
    let url: String?
    let target: String?
}

// MARK: - ButtonRendererText
struct ButtonRendererText: Codable {
    let simpleText: String?
}

// MARK: - StyleClass
struct StyleClass: Codable {
    let value: String?
}

// MARK: - MusicCardShelfRenderer
struct MusicCardShelfRenderer: Codable {
    let thumbnail: MusicResponsiveListItemRendererThumbnail?
    let buttons: [ButtonElement]?
    let subtitle: Subtitle?
    let menu: MusicCardShelfRendererMenu?
    let onTap: OnTap?
    let title: Title?
    let header: Header?
    let contents: [MusicCardShelfRendererContent]?
    let trackingParams: String?
    let thumbnailOverlay: ThumbnailOverlay?
}

// MARK: - ButtonElement
struct ButtonElement: Codable {
    let buttonRenderer: FluffyButtonRenderer?
}

// MARK: - FluffyButtonRenderer
struct FluffyButtonRenderer: Codable {
    let style: String?
    let accessibility: AccessibilityAccessibilityData?
    let size: String?
    let text: BottomText?
    let isDisabled: Bool?
    let accessibilityData: AccessibilityPauseDataClass?
    let trackingParams: String?
    let icon: Icon?
    let command: ButtonRendererCommand?
}

// MARK: - AccessibilityAccessibilityData
struct AccessibilityAccessibilityData: Codable {
    let label: String?
}

// MARK: - AccessibilityPauseDataClass
struct AccessibilityPauseDataClass: Codable {
    let accessibilityData: AccessibilityAccessibilityData?
}

// MARK: - ButtonRendererCommand
struct ButtonRendererCommand: Codable {
    let clickTrackingParams: String?
    let watchEndpoint: CommandWatchEndpoint?
    let modalEndpoint: ModalEndpoint?
}

// MARK: - ModalEndpoint
struct ModalEndpoint: Codable {
    let modal: Modal?
}

// MARK: - Modal
struct Modal: Codable {
    let modalWithTitleAndButtonRenderer: ModalWithTitleAndButtonRenderer?
}

// MARK: - ModalWithTitleAndButtonRenderer
struct ModalWithTitleAndButtonRenderer: Codable {
    let title, content: BottomText?
    let button: ModalWithTitleAndButtonRendererButton?
}

// MARK: - ModalWithTitleAndButtonRendererButton
struct ModalWithTitleAndButtonRendererButton: Codable {
    let buttonRenderer: TentacledButtonRenderer?
}

// MARK: - TentacledButtonRenderer
struct TentacledButtonRenderer: Codable {
    let isDisabled: Bool?
    let style: StyleEnum?
    let trackingParams: String?
    let navigationEndpoint: FluffyNavigationEndpoint?
    let text: BottomText?
}

// MARK: - FluffyNavigationEndpoint
struct FluffyNavigationEndpoint: Codable {
    let clickTrackingParams: String?
    let signInEndpoint: SignInEndpoint?
}

// MARK: - SignInEndpoint
struct SignInEndpoint: Codable {
    let hack: Bool?
}

enum StyleEnum: String, Codable {
    case styleBlueText = "STYLE_BLUE_TEXT"
}

// MARK: - BottomText
struct BottomText: Codable {
    let runs: [BottomTextRun]?
}

// MARK: - BottomTextRun
struct BottomTextRun: Codable {
    let text: String?
}

// MARK: - CommandWatchEndpoint
struct CommandWatchEndpoint: Codable {
    let videoID: String?
    let watchEndpointMusicSupportedConfigs: PurpleWatchEndpointMusicSupportedConfigs?
    let params: Params?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case watchEndpointMusicSupportedConfigs, params
    }
}

enum Params: String, Codable {
    case wAEB = "wAEB"
    case wAEB8GECGAE3D = "wAEB8gECGAE%3D"
    case wAEB8GECKAE3D = "wAEB8gECKAE%3D"
}

// MARK: - PurpleWatchEndpointMusicSupportedConfigs
struct PurpleWatchEndpointMusicSupportedConfigs: Codable {
    let watchEndpointMusicConfig: PurpleWatchEndpointMusicConfig?
}

// MARK: - PurpleWatchEndpointMusicConfig
struct PurpleWatchEndpointMusicConfig: Codable {
    let musicVideoType: MusicVideoType?
}

enum MusicVideoType: String, Codable {
    case musicVideoTypeAtv = "MUSIC_VIDEO_TYPE_ATV"
    case musicVideoTypeOfficialSourceMusic = "MUSIC_VIDEO_TYPE_OFFICIAL_SOURCE_MUSIC"
    case musicVideoTypeOmv = "MUSIC_VIDEO_TYPE_OMV"
    case musicVideoTypePodcastEpisode = "MUSIC_VIDEO_TYPE_PODCAST_EPISODE"
    case musicVideoTypeUgc = "MUSIC_VIDEO_TYPE_UGC"
}

// MARK: - MusicCardShelfRendererContent
struct MusicCardShelfRendererContent: Codable {
    let messageRenderer: FluffyMessageRenderer?
    let musicResponsiveListItemRenderer: PurpleMusicResponsiveListItemRenderer?
}

// MARK: - FluffyMessageRenderer
struct FluffyMessageRenderer: Codable {
    let style: StyleClass?
    let text: BottomText?
    let trackingParams: String?
}

// MARK: - PurpleMusicResponsiveListItemRenderer
struct PurpleMusicResponsiveListItemRenderer: Codable {
    let thumbnail: MusicResponsiveListItemRendererThumbnail?
    let menu: MusicCardShelfRendererMenu?
    let playlistItemData: PlaylistItemData?
    let flexColumns: [FlexColumn]?
    let itemHeight: ItemHeight?
    let overlay: PurpleOverlay?
    let trackingParams, flexColumnDisplayStyle: String?
}

// MARK: - FlexColumn
struct FlexColumn: Codable {
    let musicResponsiveListItemFlexColumnRenderer: MusicResponsiveListItemFlexColumnRenderer?
}

// MARK: - MusicResponsiveListItemFlexColumnRenderer
struct MusicResponsiveListItemFlexColumnRenderer: Codable {
    let displayPriority: DisplayPriority?
    let text: MusicResponsiveListItemFlexColumnRendererText?
}

enum DisplayPriority: String, Codable {
    case musicResponsiveListItemColumnDisplayPriorityHigh = "MUSIC_RESPONSIVE_LIST_ITEM_COLUMN_DISPLAY_PRIORITY_HIGH"
}

// MARK: - MusicResponsiveListItemFlexColumnRendererText
struct MusicResponsiveListItemFlexColumnRendererText: Codable {
    let runs: [PurpleRun]?
    let accessibility: AccessibilityPauseDataClass?
}

// MARK: - PurpleRun
struct PurpleRun: Codable {
    let navigationEndpoint: TentacledNavigationEndpoint?
    let text: String?
}

// MARK: - TentacledNavigationEndpoint
struct TentacledNavigationEndpoint: Codable {
    let clickTrackingParams: String?
    let watchEndpoint: OnTapWatchEndpoint?
    let browseEndpoint: BrowseEndpoint?
}

// MARK: - BrowseEndpoint
struct BrowseEndpoint: Codable {
    let browseID: String?
    let browseEndpointContextSupportedConfigs: BrowseEndpointContextSupportedConfigs?

    enum CodingKeys: String, CodingKey {
        case browseID = "browseId"
        case browseEndpointContextSupportedConfigs
    }
}

// MARK: - BrowseEndpointContextSupportedConfigs
struct BrowseEndpointContextSupportedConfigs: Codable {
    let browseEndpointContextMusicConfig: BrowseEndpointContextMusicConfig?
}

// MARK: - BrowseEndpointContextMusicConfig
struct BrowseEndpointContextMusicConfig: Codable {
    let pageType: PageType?
}

enum PageType: String, Codable {
    case musicPageTypeAlbum = "MUSIC_PAGE_TYPE_ALBUM"
    case musicPageTypeArtist = "MUSIC_PAGE_TYPE_ARTIST"
    case musicPageTypeNonMusicAudioTrackPage = "MUSIC_PAGE_TYPE_NON_MUSIC_AUDIO_TRACK_PAGE"
    case musicPageTypePlaylist = "MUSIC_PAGE_TYPE_PLAYLIST"
    case musicPageTypePodcastShowDetailPage = "MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE"
    case musicPageTypeTrackCredits = "MUSIC_PAGE_TYPE_TRACK_CREDITS"
    case musicPageTypeUserChannel = "MUSIC_PAGE_TYPE_USER_CHANNEL"
}

// MARK: - OnTapWatchEndpoint
struct OnTapWatchEndpoint: Codable {
    let videoID: String?
    let watchEndpointMusicSupportedConfigs: PurpleWatchEndpointMusicSupportedConfigs?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case watchEndpointMusicSupportedConfigs
    }
}

enum ItemHeight: String, Codable {
    case musicResponsiveListItemHeightTall = "MUSIC_RESPONSIVE_LIST_ITEM_HEIGHT_TALL"
}

// MARK: - MusicCardShelfRendererMenu
struct MusicCardShelfRendererMenu: Codable {
    let menuRenderer: PurpleMenuRenderer?
}

// MARK: - PurpleMenuRenderer
struct PurpleMenuRenderer: Codable {
    let items: [PurpleItem]?
    let accessibility: AccessibilityPauseDataClass?
    let trackingParams: String?
}

// MARK: - PurpleItem
struct PurpleItem: Codable {
    let menuNavigationItemRenderer, menuServiceItemRenderer: MenuItemRenderer?
    let toggleMenuServiceItemRenderer: ToggleMenuServiceItemRenderer?
}

// MARK: - MenuItemRenderer
struct MenuItemRenderer: Codable {
    let icon: Icon?
    let trackingParams: String?
    let navigationEndpoint: MenuNavigationItemRendererNavigationEndpoint?
    let text: BottomText?
    let serviceEndpoint: MenuNavigationItemRendererServiceEndpoint?
}

// MARK: - MenuNavigationItemRendererNavigationEndpoint
struct MenuNavigationItemRendererNavigationEndpoint: Codable {
    let clickTrackingParams: String?
    let watchEndpoint: PurpleWatchEndpoint?
    let modalEndpoint: ModalEndpoint?
    let browseEndpoint: BrowseEndpoint?
    let shareEntityEndpoint: ShareEntityEndpoint?
    let watchPlaylistEndpoint: WatchPlaylistEndpoint?
}

// MARK: - ShareEntityEndpoint
struct ShareEntityEndpoint: Codable {
    let serializedShareEntity: String?
    let sharePanelType: SharePanelType?
}

enum SharePanelType: String, Codable {
    case sharePanelTypeUnifiedSharePanel = "SHARE_PANEL_TYPE_UNIFIED_SHARE_PANEL"
}

// MARK: - PurpleWatchEndpoint
struct PurpleWatchEndpoint: Codable {
    let playlistID: String?
    let loggingContext: LoggingContext?
    let videoID: String?
    let params: Params?
    let watchEndpointMusicSupportedConfigs: FluffyWatchEndpointMusicSupportedConfigs?

    enum CodingKeys: String, CodingKey {
        case playlistID = "playlistId"
        case loggingContext
        case videoID = "videoId"
        case params, watchEndpointMusicSupportedConfigs
    }
}

// MARK: - LoggingContext
struct LoggingContext: Codable {
    let vssLoggingContext: VssLoggingContext?
}

// MARK: - VssLoggingContext
struct VssLoggingContext: Codable {
    let serializedContextData: String?
}

// MARK: - FluffyWatchEndpointMusicSupportedConfigs
struct FluffyWatchEndpointMusicSupportedConfigs: Codable {
    let watchEndpointMusicConfig: FluffyWatchEndpointMusicConfig?
}

// MARK: - FluffyWatchEndpointMusicConfig
struct FluffyWatchEndpointMusicConfig: Codable {
    let musicVideoType: MusicVideoType?
    let suggestedInitialPlayerMode: SuggestedInitialPlayerMode?
}

enum SuggestedInitialPlayerMode: String, Codable {
    case musicWatchPlayerModeExpanded = "MUSIC_WATCH_PLAYER_MODE_EXPANDED"
}

// MARK: - WatchPlaylistEndpoint
struct WatchPlaylistEndpoint: Codable {
    let playlistID: String?
    let params: Params?

    enum CodingKeys: String, CodingKey {
        case playlistID = "playlistId"
        case params
    }
}

// MARK: - MenuNavigationItemRendererServiceEndpoint
struct MenuNavigationItemRendererServiceEndpoint: Codable {
    let clickTrackingParams: String?
    let queueAddEndpoint: QueueAddEndpoint?
}

// MARK: - QueueAddEndpoint
struct QueueAddEndpoint: Codable {
    let commands: [CommandElement]?
    let queueInsertPosition: QueueInsertPosition?
    let queueTarget: QueueTarget?
}

// MARK: - CommandElement
struct CommandElement: Codable {
    let clickTrackingParams: String?
    let addToToastAction: AddToToastAction?
}

// MARK: - AddToToastAction
struct AddToToastAction: Codable {
    let item: AddToToastActionItem?
}

// MARK: - AddToToastActionItem
struct AddToToastActionItem: Codable {
    let notificationTextRenderer: NotificationTextRenderer?
}

// MARK: - NotificationTextRenderer
struct NotificationTextRenderer: Codable {
    let successResponseText: BottomText?
    let trackingParams: String?
}

enum QueueInsertPosition: String, Codable {
    case insertAfterCurrentVideo = "INSERT_AFTER_CURRENT_VIDEO"
    case insertAtEnd = "INSERT_AT_END"
}

// MARK: - QueueTarget
struct QueueTarget: Codable {
    let videoID: String?
    let onEmptyQueue: OnEmptyQueue?
    let playlistID: String?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case onEmptyQueue
        case playlistID = "playlistId"
    }
}

// MARK: - OnEmptyQueue
struct OnEmptyQueue: Codable {
    let clickTrackingParams: String?
    let watchEndpoint: OnEmptyQueueWatchEndpoint?
}

// MARK: - OnEmptyQueueWatchEndpoint
struct OnEmptyQueueWatchEndpoint: Codable {
    let videoID, playlistID: String?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case playlistID = "playlistId"
    }
}

// MARK: - ToggleMenuServiceItemRenderer
struct ToggleMenuServiceItemRenderer: Codable {
    let toggledText: BottomText?
    let defaultServiceEndpoint: DefaultServiceEndpoint?
    let defaultIcon: Icon?
    let trackingParams: String?
    let defaultText: BottomText?
    let toggledIcon: Icon?
    let toggledServiceEndpoint: ToggledServiceEndpoint?
}

// MARK: - DefaultServiceEndpoint
struct DefaultServiceEndpoint: Codable {
    let clickTrackingParams: String?
    let modalEndpoint: ModalEndpoint?
}

// MARK: - ToggledServiceEndpoint
struct ToggledServiceEndpoint: Codable {
    let clickTrackingParams: String?
    let likeEndpoint: LikeEndpoint?
}

// MARK: - LikeEndpoint
struct LikeEndpoint: Codable {
    let status: String?
    let target: Target?
}

// MARK: - Target
struct Target: Codable {
    let playlistID: String?

    enum CodingKeys: String, CodingKey {
        case playlistID = "playlistId"
    }
}

// MARK: - PurpleOverlay
struct PurpleOverlay: Codable {
    let musicItemThumbnailOverlayRenderer: PurpleMusicItemThumbnailOverlayRenderer?
}

// MARK: - PurpleMusicItemThumbnailOverlayRenderer
struct PurpleMusicItemThumbnailOverlayRenderer: Codable {
    let contentPosition: ContentPosition?
    let content: PurpleContent?
    let displayStyle: DisplayStyle?
    let background: Background?
}

// MARK: - Background
struct Background: Codable {
    let verticalGradient: VerticalGradient?
}

// MARK: - VerticalGradient
struct VerticalGradient: Codable {
    let gradientLayerColors: [String]?
}

// MARK: - PurpleContent
struct PurpleContent: Codable {
    let musicPlayButtonRenderer: PurpleMusicPlayButtonRenderer?
}

// MARK: - PurpleMusicPlayButtonRenderer
struct PurpleMusicPlayButtonRenderer: Codable {
    let rippleTarget: RippleTarget?
    let iconColor, backgroundColor, iconLoadingColor: Int?
    let pauseIcon: Icon?
    let activeScaleFactor: Int?
    let buttonSize: ButtonSize?
    let playNavigationEndpoint: PurplePlayNavigationEndpoint?
    let loadingIndicatorColor: Int?
    let playIcon: Icon?
    let activeBackgroundColor: Int?
    let trackingParams: String?
    let accessibilityPlayData: AccessibilityPauseDataClass?
    let playingIcon: Icon?
    let accessibilityPauseData: AccessibilityPauseDataClass?
}

enum ButtonSize: String, Codable {
    case musicPlayButtonSizeSmall = "MUSIC_PLAY_BUTTON_SIZE_SMALL"
}

// MARK: - PurplePlayNavigationEndpoint
struct PurplePlayNavigationEndpoint: Codable {
    let clickTrackingParams: String?
    let watchEndpoint: FluffyWatchEndpoint?
}

// MARK: - FluffyWatchEndpoint
struct FluffyWatchEndpoint: Codable {
    let videoID: String?
    let watchEndpointMusicSupportedConfigs: FluffyWatchEndpointMusicSupportedConfigs?
    let playerParams: String?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case watchEndpointMusicSupportedConfigs, playerParams
    }
}

enum RippleTarget: String, Codable {
    case musicPlayButtonRippleTargetSelf = "MUSIC_PLAY_BUTTON_RIPPLE_TARGET_SELF"
}

enum ContentPosition: String, Codable {
    case musicItemThumbnailOverlayContentPositionCentered = "MUSIC_ITEM_THUMBNAIL_OVERLAY_CONTENT_POSITION_CENTERED"
}

enum DisplayStyle: String, Codable {
    case musicItemThumbnailOverlayDisplayStylePersistent = "MUSIC_ITEM_THUMBNAIL_OVERLAY_DISPLAY_STYLE_PERSISTENT"
}

// MARK: - PlaylistItemData
struct PlaylistItemData: Codable {
    let videoID: String?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
    }
}

// MARK: - MusicResponsiveListItemRendererThumbnail
struct MusicResponsiveListItemRendererThumbnail: Codable {
    let musicThumbnailRenderer: MusicThumbnailRenderer?
}

// MARK: - MusicThumbnailRenderer
struct MusicThumbnailRenderer: Codable {
    let thumbnailScale: ThumbnailScale?
    let thumbnailCrop: ThumbnailCrop?
    let trackingParams: String?
    let thumbnail: MusicThumbnailRendererThumbnail?
}

// MARK: - MusicThumbnailRendererThumbnail
struct MusicThumbnailRendererThumbnail: Codable {
    let thumbnails: [ThumbnailElement]?
}

// MARK: - ThumbnailElement
struct ThumbnailElement: Codable {
    let url: String?
    let width, height: Int?
}

enum ThumbnailCrop: String, Codable {
    case musicThumbnailCropCircle = "MUSIC_THUMBNAIL_CROP_CIRCLE"
    case musicThumbnailCropUnspecified = "MUSIC_THUMBNAIL_CROP_UNSPECIFIED"
}

enum ThumbnailScale: String, Codable {
    case musicThumbnailScaleAspectFill = "MUSIC_THUMBNAIL_SCALE_ASPECT_FILL"
    case musicThumbnailScaleAspectFit = "MUSIC_THUMBNAIL_SCALE_ASPECT_FIT"
}

// MARK: - Header
struct Header: Codable {
    let musicCardShelfHeaderBasicRenderer: MusicCardShelfHeaderBasicRenderer?
}

// MARK: - MusicCardShelfHeaderBasicRenderer
struct MusicCardShelfHeaderBasicRenderer: Codable {
    let title, strapline: BottomText?
    let trackingParams: String?
}

// MARK: - OnTap
struct OnTap: Codable {
    let clickTrackingParams: String?
    let watchEndpoint: OnTapWatchEndpoint?
}

// MARK: - Subtitle
struct Subtitle: Codable {
    let runs: [SubtitleRun]?
    let accessibility: AccessibilityPauseDataClass?
}

// MARK: - SubtitleRun
struct SubtitleRun: Codable {
    let text: String?
    let navigationEndpoint: MusicResponsiveListItemRendererNavigationEndpoint?
}

// MARK: - MusicResponsiveListItemRendererNavigationEndpoint
struct MusicResponsiveListItemRendererNavigationEndpoint: Codable {
    let clickTrackingParams: String?
    let browseEndpoint: BrowseEndpoint?
}

// MARK: - ThumbnailOverlay
struct ThumbnailOverlay: Codable {
    let musicItemThumbnailOverlayRenderer: ThumbnailOverlayMusicItemThumbnailOverlayRenderer?
}

// MARK: - ThumbnailOverlayMusicItemThumbnailOverlayRenderer
struct ThumbnailOverlayMusicItemThumbnailOverlayRenderer: Codable {
    let contentPosition: ContentPosition?
    let content: FluffyContent?
    let displayStyle: DisplayStyle?
    let background: Background?
}

// MARK: - FluffyContent
struct FluffyContent: Codable {
    let musicPlayButtonRenderer: FluffyMusicPlayButtonRenderer?
}

// MARK: - FluffyMusicPlayButtonRenderer
struct FluffyMusicPlayButtonRenderer: Codable {
    let rippleTarget: RippleTarget?
    let iconColor, backgroundColor, iconLoadingColor: Int?
    let pauseIcon: Icon?
    let activeScaleFactor: Int?
    let buttonSize: String?
    let playNavigationEndpoint: OnTap?
    let loadingIndicatorColor: Int?
    let playIcon: Icon?
    let activeBackgroundColor: Int?
    let trackingParams: String?
    let accessibilityPlayData: AccessibilityPauseDataClass?
    let playingIcon: Icon?
    let accessibilityPauseData: AccessibilityPauseDataClass?
}

// MARK: - Title
struct Title: Codable {
    let runs: [FluffyRun]?
}

// MARK: - FluffyRun
struct FluffyRun: Codable {
    let navigationEndpoint: OnTap?
    let text: String?
}

// MARK: - MusicShelfRenderer
struct MusicShelfRenderer: Codable {
    let shelfDivider: ShelfDivider?
    let title: BottomText?
    let trackingParams: String?
    let contents: [MusicShelfRendererContent]?
    let bottomText: BottomText?
    let bottomEndpoint: BottomEndpoint?
}

// MARK: - BottomEndpoint
struct BottomEndpoint: Codable {
    let clickTrackingParams: String?
    let searchEndpoint: SearchEndpoint?
}

// MARK: - SearchEndpoint
struct SearchEndpoint: Codable {
    let query, params: String?
}

// MARK: - MusicShelfRendererContent
struct MusicShelfRendererContent: Codable {
    let musicResponsiveListItemRenderer: FluffyMusicResponsiveListItemRenderer?
}

// MARK: - FluffyMusicResponsiveListItemRenderer
struct FluffyMusicResponsiveListItemRenderer: Codable {
    let thumbnail: MusicResponsiveListItemRendererThumbnail?
    let badges: [Badge]?
    let menu: PurpleMenu?
    let playlistItemData: PlaylistItemData?
    let flexColumns: [FlexColumn]?
    let itemHeight: ItemHeight?
    let overlay: FluffyOverlay?
    let trackingParams, flexColumnDisplayStyle: String?
    let navigationEndpoint: MusicResponsiveListItemRendererNavigationEndpoint?
}

// MARK: - Badge
struct Badge: Codable {
    let musicInlineBadgeRenderer: MusicInlineBadgeRenderer?
}

// MARK: - MusicInlineBadgeRenderer
struct MusicInlineBadgeRenderer: Codable {
    let accessibilityData: AccessibilityPauseDataClass?
    let icon: Icon?
    let trackingParams: String?
}

// MARK: - PurpleMenu
struct PurpleMenu: Codable {
    let menuRenderer: FluffyMenuRenderer?
}

// MARK: - FluffyMenuRenderer
struct FluffyMenuRenderer: Codable {
    let items: [FluffyItem]?
    let accessibility: AccessibilityPauseDataClass?
    let trackingParams: String?
    let topLevelButtons: [TopLevelButton]?
}

// MARK: - FluffyItem
struct FluffyItem: Codable {
    let menuNavigationItemRenderer, menuServiceItemRenderer: MenuItemRenderer?
    let toggleMenuServiceItemRenderer: ToggleMenuServiceItemRenderer?
    let menuServiceItemDownloadRenderer: MenuServiceItemDownloadRenderer?
}

// MARK: - MenuServiceItemDownloadRenderer
struct MenuServiceItemDownloadRenderer: Codable {
    let serviceEndpoint: MenuServiceItemDownloadRendererServiceEndpoint?
    let trackingParams: String?
}

// MARK: - MenuServiceItemDownloadRendererServiceEndpoint
struct MenuServiceItemDownloadRendererServiceEndpoint: Codable {
    let clickTrackingParams: String?
    let offlineVideoEndpoint: OfflineVideoEndpoint?
}

// MARK: - OfflineVideoEndpoint
struct OfflineVideoEndpoint: Codable {
    let videoID: String?
    let onAddCommand: OnAddCommand?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case onAddCommand
    }
}

// MARK: - OnAddCommand
struct OnAddCommand: Codable {
    let clickTrackingParams: String?
    let getDownloadActionCommand: GetDownloadActionCommand?
}

// MARK: - GetDownloadActionCommand
struct GetDownloadActionCommand: Codable {
    let videoID, params: String?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case params
    }
}

// MARK: - TopLevelButton
struct TopLevelButton: Codable {
    let likeButtonRenderer: LikeButtonRenderer?
}

// MARK: - LikeButtonRenderer
struct LikeButtonRenderer: Codable {
    let likeStatus, trackingParams: String?
    let likesAllowed: Bool?
    let dislikeNavigationEndpoint: DefaultServiceEndpoint?
    let target: PlaylistItemData?
    let likeCommand: DefaultServiceEndpoint?
}

// MARK: - FluffyOverlay
struct FluffyOverlay: Codable {
    let musicItemThumbnailOverlayRenderer: FluffyMusicItemThumbnailOverlayRenderer?
}

// MARK: - FluffyMusicItemThumbnailOverlayRenderer
struct FluffyMusicItemThumbnailOverlayRenderer: Codable {
    let contentPosition: ContentPosition?
    let content: TentacledContent?
    let displayStyle: DisplayStyle?
    let background: Background?
}

// MARK: - TentacledContent
struct TentacledContent: Codable {
    let musicPlayButtonRenderer: TentacledMusicPlayButtonRenderer?
}

// MARK: - TentacledMusicPlayButtonRenderer
struct TentacledMusicPlayButtonRenderer: Codable {
    let rippleTarget: RippleTarget?
    let iconColor, backgroundColor, iconLoadingColor: Int?
    let pauseIcon: Icon?
    let activeScaleFactor: Int?
    let buttonSize: ButtonSize?
    let playNavigationEndpoint: FluffyPlayNavigationEndpoint?
    let loadingIndicatorColor: Int?
    let playIcon: Icon?
    let activeBackgroundColor: Int?
    let trackingParams: String?
    let accessibilityPlayData: AccessibilityPauseDataClass?
    let playingIcon: Icon?
    let accessibilityPauseData: AccessibilityPauseDataClass?
}

// MARK: - FluffyPlayNavigationEndpoint
struct FluffyPlayNavigationEndpoint: Codable {
    let clickTrackingParams: String?
    let watchEndpoint: TentacledWatchEndpoint?
    let watchPlaylistEndpoint: WatchPlaylistEndpoint?
}

// MARK: - TentacledWatchEndpoint
struct TentacledWatchEndpoint: Codable {
    let videoID: String?
    let watchEndpointMusicSupportedConfigs: FluffyWatchEndpointMusicSupportedConfigs?
    let params: String?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case watchEndpointMusicSupportedConfigs, params
    }
}

// MARK: - ShelfDivider
struct ShelfDivider: Codable {
    let musicShelfDividerRenderer: MusicShelfDividerRenderer?
}

// MARK: - MusicShelfDividerRenderer
struct MusicShelfDividerRenderer: Codable {
    let hidden: Bool?
}

