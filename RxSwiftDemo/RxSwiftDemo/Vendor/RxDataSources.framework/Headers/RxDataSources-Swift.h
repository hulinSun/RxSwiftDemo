// Generated by Apple Swift version 3.0.1 (swiftlang-800.0.58.6 clang-800.0.42.1)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import Foundation;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"

@interface UICollectionView (SWIFT_EXTENSION(RxDataSources))
- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> * _Nonnull)paths animationStyle:(UITableViewRowAnimation)animationStyle;
- (void)deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> * _Nonnull)paths animationStyle:(UITableViewRowAnimation)animationStyle;
- (void)moveItemAtIndexPath:(NSIndexPath * _Nonnull)from to:(NSIndexPath * _Nonnull)to;
- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> * _Nonnull)paths animationStyle:(UITableViewRowAnimation)animationStyle;
- (void)insertSections:(NSArray<NSNumber *> * _Nonnull)sections animationStyle:(UITableViewRowAnimation)animationStyle;
- (void)deleteSections:(NSArray<NSNumber *> * _Nonnull)sections animationStyle:(UITableViewRowAnimation)animationStyle;
- (void)moveSection:(NSInteger)from to:(NSInteger)to;
- (void)reloadSections:(NSArray<NSNumber *> * _Nonnull)sections animationStyle:(UITableViewRowAnimation)animationStyle;
@end


@interface UITableView (SWIFT_EXTENSION(RxDataSources))
- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> * _Nonnull)paths animationStyle:(UITableViewRowAnimation)animationStyle;
- (void)deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> * _Nonnull)paths animationStyle:(UITableViewRowAnimation)animationStyle;
- (void)moveItemAtIndexPath:(NSIndexPath * _Nonnull)from to:(NSIndexPath * _Nonnull)to;
- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> * _Nonnull)paths animationStyle:(UITableViewRowAnimation)animationStyle;
- (void)insertSections:(NSArray<NSNumber *> * _Nonnull)sections animationStyle:(UITableViewRowAnimation)animationStyle;
- (void)deleteSections:(NSArray<NSNumber *> * _Nonnull)sections animationStyle:(UITableViewRowAnimation)animationStyle;
- (void)moveSection:(NSInteger)from to:(NSInteger)to;
- (void)reloadSections:(NSArray<NSNumber *> * _Nonnull)sections animationStyle:(UITableViewRowAnimation)animationStyle;
@end

@class UICollectionViewCell;
@class UICollectionReusableView;

SWIFT_CLASS("_TtC13RxDataSources34_CollectionViewSectionedDataSource")
@interface _CollectionViewSectionedDataSource : NSObject <UICollectionViewDataSource>
- (NSInteger)_rx_numberOfSectionsIn:(UICollectionView * _Nonnull)collectionView;
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView * _Nonnull)collectionView;
- (NSInteger)_rx_collectionView:(UICollectionView * _Nonnull)collectionView numberOfItemsInSection:(NSInteger)section;
- (NSInteger)collectionView:(UICollectionView * _Nonnull)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell * _Nonnull)_rx_collectionView:(UICollectionView * _Nonnull)collectionView cellForItemAt:(NSIndexPath * _Nonnull)indexPath;
- (UICollectionViewCell * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView cellForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (UICollectionReusableView * _Nonnull)_rx_collectionView:(UICollectionView * _Nonnull)collectionView viewForSupplementaryElementOfKind:(NSString * _Nonnull)kind atIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (UICollectionReusableView * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView viewForSupplementaryElementOfKind:(NSString * _Nonnull)kind atIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (BOOL)_rx_collectionView:(UICollectionView * _Nonnull)collectionView canMoveItemAt:(NSIndexPath * _Nonnull)indexPath;
- (BOOL)collectionView:(UICollectionView * _Nonnull)collectionView canMoveItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)_rx_collectionView:(UICollectionView * _Nonnull)collectionView moveItemAt:(NSIndexPath * _Nonnull)sourceIndexPath to:(NSIndexPath * _Nonnull)destinationIndexPath;
- (void)collectionView:(UICollectionView * _Nonnull)collectionView moveItemAtIndexPath:(NSIndexPath * _Nonnull)sourceIndexPath toIndexPath:(NSIndexPath * _Nonnull)destinationIndexPath;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UITableViewCell;

SWIFT_CLASS("_TtC13RxDataSources29_TableViewSectionedDataSource")
@interface _TableViewSectionedDataSource : NSObject <UITableViewDataSource>
- (NSInteger)_rx_numberOfSectionsIn:(UITableView * _Nonnull)tableView;
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView;
- (NSInteger)_rx_tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)_rx_tableView:(UITableView * _Nonnull)tableView cellForRowAt:(NSIndexPath * _Nonnull)indexPath;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (NSString * _Nullable)_rx_tableView:(UITableView * _Nonnull)tableView titleForHeaderInSection:(NSInteger)section;
- (NSString * _Nullable)tableView:(UITableView * _Nonnull)tableView titleForHeaderInSection:(NSInteger)section;
- (NSString * _Nullable)_rx_tableView:(UITableView * _Nonnull)tableView titleForFooterInSection:(NSInteger)section;
- (NSString * _Nullable)tableView:(UITableView * _Nonnull)tableView titleForFooterInSection:(NSInteger)section;
- (BOOL)_rx_tableView:(UITableView * _Nonnull)tableView canEditRowAt:(NSIndexPath * _Nonnull)indexPath;
- (BOOL)tableView:(UITableView * _Nonnull)tableView canEditRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (BOOL)_rx_tableView:(UITableView * _Nonnull)tableView canMoveRowAt:(NSIndexPath * _Nonnull)indexPath;
- (BOOL)tableView:(UITableView * _Nonnull)tableView canMoveRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (NSArray<NSString *> * _Nullable)_rx_sectionIndexTitlesFor:(UITableView * _Nonnull)tableView;
- (NSArray<NSString *> * _Nullable)sectionIndexTitlesForTableView:(UITableView * _Nonnull)tableView;
- (NSInteger)_rx_tableView:(UITableView * _Nonnull)tableView sectionForSectionIndexTitle:(NSString * _Nonnull)title at:(NSInteger)index;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView sectionForSectionIndexTitle:(NSString * _Nonnull)title atIndex:(NSInteger)index;
- (void)_rx_tableView:(UITableView * _Nonnull)tableView moveRowAt:(NSIndexPath * _Nonnull)sourceIndexPath to:(NSIndexPath * _Nonnull)destinationIndexPath;
- (void)tableView:(UITableView * _Nonnull)tableView moveRowAtIndexPath:(NSIndexPath * _Nonnull)sourceIndexPath toIndexPath:(NSIndexPath * _Nonnull)destinationIndexPath;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
