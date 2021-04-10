import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  final double height;
  final double width;
  final Alignment alignment;
  final String text;
  final dynamic style;
  final TextOverflow overflow;
  final int maxLines;
  final bool singleLine;
  final EdgeInsets contentPadding;
  final EdgeInsets margin;
  final Color bkgColor;
  final Color borderColor;
  final double borderRadius;
  final GestureTapCallback onClick;
  final double borderWidth;
  final double maxWidth;
  final double maxHeight;

  SimpleText(this.text,
      {Key key,
      this.height,
      this.width,
      this.style,
      this.alignment = Alignment.center,
      this.overflow = TextOverflow.ellipsis,
      this.maxLines,
      this.singleLine = false,
      this.contentPadding,
      this.margin,
      this.bkgColor,
      this.borderColor,
      this.borderRadius = 0,
      this.onClick,
      this.borderWidth = 1,
      this.maxWidth,
      this.maxHeight})
      : assert(
            style == null || style is TextStyle || style is TextStyleBuilder),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onClick == null) return coreText();
    return GestureDetector(
      onTap: onClick,
      child: coreText(),
    );
  }

  TextStyle _getStyle() {
    if (style is TextStyle) return style as TextStyle;
    if (style is TextStyleBuilder) return (style as TextStyleBuilder).build;
    return null;
  }

  Widget coreText() {
    var textStyle = _getStyle();

    TextOverflow overflow = this.overflow;
    int maxLines = this.maxLines;
    if (singleLine) {
      overflow = TextOverflow.ellipsis;
      maxLines = 1;
    }

    BoxDecoration decoration;
    if (bkgColor != null || borderColor != null) {
      decoration = BoxDecoration(
          color: bkgColor,
          border: borderColor == null
              ? null
              : Border.all(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius));
    }

    BoxConstraints constraints;
    if (maxHeight != null || maxWidth != null) {
      constraints = BoxConstraints(
          minWidth: 0,
          minHeight: 0,
          maxWidth: maxWidth ?? double.infinity,
          maxHeight: maxHeight ?? double.infinity);
    }

    return Container(
      decoration: decoration,
      constraints: constraints,
      padding: contentPadding,
      margin: margin,
      height: height,
      width: width,
      alignment: alignment,
      child: Text(
        text,
        style: textStyle,
        overflow: overflow,
        maxLines: maxLines,
      ),
    );
  }
}

class TextStyleBuilder {
  double _size;
  Color _color;
  FontWeight _weight;
  double _height;

  TextStyleBuilder size(double size) {
    this._size = size;
    return this;
  }

  TextStyleBuilder color(dynamic color) {
    if (color is Color) {
      this._color = color;
    }
    if (color is int) {
      this._color = Color(color);
    }
    return this;
  }

  TextStyleBuilder weight(FontWeight weight) {
    this._weight = weight;
    return this;
  }

  TextStyleBuilder height(double height) {
    this._height = height;
    return this;
  }

  TextStyle get build {
    return TextStyle(
        fontSize: _size, color: _color, fontWeight: _weight, height: _height);
  }
}
