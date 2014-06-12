#pragma once
#ifndef  __SK_GAME_METADATA_H__
#define  __SK_GAME_METADATA_H__

#include "platform/CCPlatformConfig.h"

//--------

#ifndef SK_PAID

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS) // Free
#define APP_STORE_URL                               "https://itunes.apple.com/us/app/neoniks-flying-phoebe/id852553704"
#define DEFAULT_LEADERBOARD_STORE_ID                "com.neoniks.flyingphoebeleaderboard"
#define INAPP_UNLOCKALL_STORE_ID                    "com.dracollc.cilinkfree.unlock"
#define INAPP_REMOVE_ADS_STORE_ID                   "com.dracollc.cilinkfree.removeads"
#define FLURRY_APP_KEY                              "WT9C62B88DP89ZYFJ755"
#define CB_APP_ID                                   "5343aa93c26ee4369e56d64d"
#define CB_APP_SIGNATURE                            "16ac6835a3b80ad5360340bf627b7bd149dcffdb"
#define REVMOB_APP_ID                               "5343ab30b223d0d955dfa670"
#define ADMOB_MEDIATION_ID                          "ca-app-pub-1480731978958686/7235666595"
#define ADCOLONY_APPLICATION_ID                     "app9ae1424d2c994149b5"
#define ADCOLONY_ZONE                               "vz80d20424dbb24404a3"
#define PLAYHEAVEN_TOKEN                            "2950bd2460b248f8b7f325a987da7bb2"
#define PLAYHEAVEN_SECRET                           "686563ed8a5f4c458c49c2aab8f84746"
#define TAPJOY_APP_ID								"NOPE"
#define TAPJOY_APP_KEY								"NOPE"


#elif (CC_TARGET_PLATFORM == CC_PLATFORM_MAC) // Free

#elif (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID) // Free

#define DEFAULT_LEADERBOARD_STORE_ID                "CgkIw5Cynv8aEAIQBw"

#define APP_STORE_URL                               "https://play.google.com/store/apps/details?id=com.dracollc.flappycrocodile&hl=en"
#define FLURRY_APP_KEY                              "NOPE"
#define FLURRY_AD_KEY                               "NOPE"
#define TAPJOY_APP_ID								"NOPE"
#define TAPJOY_APP_KEY								"NOPE"
#define SPONSORPAY_APP_ID                           "NOPE"
#define SPONSORPAY_APP_KEY                          "NOPE"
#define ADCOLONY_APPLICATION_ID                     "NOPE"
#define ADCOLONY_ZONE                               "NOPE"

#define ADMOB_MEDIATION_ID                          "a152effe648927f"

#elif (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32) //

#else
#error "SKGameMetadata does not support this platfrom, fix it"
#endif

#else // #ifdef SK_PAID

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS) // Paid
#define APP_STORE_URL                               "https://itunes.apple.com/us/app/neoniks-flying-phoebe/id852553704?ls=1&mt=8"
#define DEFAULT_LEADERBOARD_STORE_ID                "com.dracollc.cilinkpaid.leader"
#define INAPP_UNLOCKALL_STORE_ID                    "com.dracollc.cilinkpaid.unlock"
#define FLURRY_APP_KEY                              "WT9C62B88DP89ZYFJ755"
#define CB_APP_ID                                   "5343aa93c26ee4369e56d64d"
#define CB_APP_SIGNATURE                            "16ac6835a3b80ad5360340bf627b7bd149dcffdb"
#define REVMOB_APP_ID                               "5343ab30b223d0d955dfa670"
#define ADCOLONY_APPLICATION_ID                     "app9ae1424d2c994149b5"
#define ADCOLONY_ZONE                               "vz80d20424dbb24404a3"
#define PLAYHEAVEN_TOKEN                            "2950bd2460b248f8b7f325a987da7bb2"
#define PLAYHEAVEN_SECRET                           "686563ed8a5f4c458c49c2aab8f84746"

#define INAPP_REMOVE_ADS_STORE_ID                   "NOPE"
#define ADMOB_MEDIATION_ID                          "NOPE"
#define TAPJOY_APP_ID								"NOPE"
#define TAPJOY_APP_KEY								"NOPE"



#elif (CC_TARGET_PLATFORM == CC_PLATFORM_MAC) // Paid


#elif (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID) // Paid

#else
#error "SKGameMetadata does not support this platfrom, fix it"
#endif


#endif // #ifdef SK_PAID


void InitAchievements();

#endif // __SK_GAME_METADATA_H__

