String markdownSampleHtml = '''
<h3>Emphasis</h3>
<pre>**<strong>bold</strong>**
__<strong>bold</strong>__
*<em>italics</em>*
_<em>italics</em>_
~~<strike>strikethrough</strike>~~</pre>

<h3>Headers</h3>
<pre># Big header
## Medium header
### Small header
#### Tiny header
##### Tiny tiny header
###### Tiny tiny tiny header
</pre>

<h3>Horizontal rules</h3>
<pre>___
---
***<pre>

<h3>Lists</h3>
<pre>
* Create a list by starting a line with '+', '-', or '*'
* Sub-lists are made by indentng 2 spaces:
  + Generic list item
  - Generic list item

1. Create ordered lists with numbers
2. Numbered list item
3. Numbered list item</pre>

<h3>Links</h3>
<pre>[Text to display](http://www.example.com)</pre>

<h3>Images</h3>
<pre>![description of the image](http://www.web_adress_to_image.com/image.jpg)</pre>


<h3>Quotes</h3>
<pre>> This is a quote.
> It can span multiple lines!
>> It can be nested by using more signs like this!
>>> And like this!!!</pre>

<h3>Displaying code</h3>
<pre>Inline `<code>code</code>`

Code highlighting like that:
```
<code>
var foo = function(bar) {
  return bar++;
};
console.log(foo(5));
</code>
```
''';

String markdownSample = '''
### Emphasis
**bold**
__bold__
*italics*
_italics_
~~strikethrough~~

---

### Headers
# Big header
## Medium header
### Small header
#### Tiny header
##### Tiny tiny header
###### Tiny tiny tiny header

---

### Horizontal rules
___
---
***

---

### Lists
* Create a list by starting a line with '+', '-', or '*'
* Sub-lists are made by indentng 2 spaces:
  + Generic list item
  - Generic list item

1. Create ordered lists with numbers
2. Numbered list item
3. Numbered list item</pre>

---

### Links
[Text to display](http://www.example.com)

---

### Images
![Minion](https://octodex.github.com/images/minion.png)

---

### Quotes
> This is a quote.
> It can span multiple lines!
>> It can be nested by using more signs like this!
>>> And like this!!!

---

### Displaying code
Inline `code`

Code highlighting like that:
```
var foo = function(bar) {
  return bar++;
};
console.log(foo(5));
```
''';