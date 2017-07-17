# Eelay

[![CI Status](http://img.shields.io/travis/zhuxietong/Eelay.svg?style=flat)](https://travis-ci.org/zhuxietong/Eelay)
[![Version](https://img.shields.io/cocoapods/v/Eelay.svg?style=flat)](http://cocoapods.org/pods/Eelay)
[![License](https://img.shields.io/cocoapods/l/Eelay.svg?style=flat)](http://cocoapods.org/pods/Eelay)
[![Platform](https://img.shields.io/cocoapods/p/Eelay.svg?style=flat)](http://cocoapods.org/pods/Eelay)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Eelay is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Eelay"
```

## Author

zhuxietong, zhuxietong@me.com

## License

Eelay is available under the MIT license. See the LICENSE file for more info.


## Demo代码分析

![demo](https://github.com/zhuxietong/EeLay/raw/master/demo.png?raw=true)



26行    对`view`视图对象的子视图进行布局

28行   将`back`添加到`view`中并添加以下布局束

> - 设置`back` **top** 到`view` **top**距离为20
> - 设置`back` **left**到`view` **left**距离为20
> - 设置`back` **bottom**到`view` **bottom**距离为-20
> - 设置`back` **right** 到`view` **right**距离为-20



29行   将`head`添加到`view`中并添加以下布局束

> - 设置`head` **width** 为 100
> - 设置`head` **height** 为 100
> - 设置`head` **top**到`view` **top** 距离为80
> - 设置`head` **centerX** 到`view` **centerX**距离为0



30行   将`name`添加到`view`中并添加以下布局束

> - 设置`name` **width** 小于等于 200
> - 设置`name` **height** 为 30
> - 设置`name` **centerX** 到`view` **centerX** 距离为-20
> - 设置`name` **top** 到`head` **bottom** 距离为30



31行   将`age`添加到`view`中并添加以下布局束

> - 设置`age` **left** 到 `name` **right** 距离为10
> - 设置`age` **centerX** 与 `name` **centerY**对齐



32行   将`content`添加到`view`中并添加以下布局束

> - 设置`content` **height** 大于等于200，该布局束的优先级为1000
> - 设置`content` **left** 相对于`view` **left** 距离为30
> - 设置`content` **bottom** 相对于`view` **bottom** 距离为-30 ,该布局束的优先级为500
> - 设置`content` **right** 相对于`view` **right** 距离为-30
> - 设置`content` **top** 与 `name` **bottom** 距离为40



### 要点分析

将一个视图（label对象）的布局信息放在一个**[Any]**对象中，

#### 1,[Any]  的第一个对象必须是将要布局的视图对象，

`[label,]`

#### 2,[Any] 中添加 Double或Int或Float值 可设置宽度，

`[label,200]，`

> 该值处理时转换成[String:Double]类型，类型中包含优先级， 值，大于小于信息；（注：其它的布局约束中，设置的值，中间处理过程也是转换成[String:Double]类型）

#### 3,[Any] 中添加 String 值可设置宽度，

`[label,200,"50"]，`

>  该值处理时转换成[String:String]类型，类型中包含优先级， 值，大于小于信息

#### 4,[Any]中添加[Any] 对象可简易连续添加多个布局束,

`[label,200,"50",[ee.T.L]]，`

> `[ee.T.L]`中包含top, left 的对齐方式，此时表示lable 与lable父视图的top,left对齐;
>
> `[ee.T.L,[20,30]]`表示top,left 对齐的偏移量 分别是20,30;
>
>  `[anther_view,ee.T.L,[20,30]]`,当第一个对象为视图类型的时候，label 的设置布局束是相对于该视图进行设置，否则的话就是想对于父视图进行设置的
>
> ###  `[anther_view,ee.B,ee.T,20]`,label 的顶部与 anther_view的地步对其
>
> ```
> easy map 对应信息NSLayoutAttribute.
> ee.T —>  NSLayoutAttribute.top,
> ee.L —>  NSLayoutAttribute.left
> ```



