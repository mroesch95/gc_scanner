import 'package:flutter/material.dart';
import 'zeplin_colors.dart';

abstract class ZeplinTextStyles {

  static const HeadlinePrimaryWhite24 = TextStyle(
    fontFamily: 'StamPete',
    fontSize: 24,
    color: ZeplinColors.white,

  );
  // Headlines 24SP
  static const HeadlinePrimaryBlue24SP = TextStyle(
    fontFamily: 'StamPete',
    fontSize: 24,
    color: ZeplinColors.primary_blue,
  );
  static const HeadlinePrimaryPink24SP = TextStyle(
    fontFamily: 'StamPete',
    fontSize: 24,
    color: ZeplinColors.primary_pink,
  );
  static const HeadlinePrimaryWhite24SP = TextStyle(
    fontFamily: 'StamPete',
    fontSize: 24,
    color: ZeplinColors.white,
  );
  static const HeadlinePrimaryBlack24SP = TextStyle(
    fontFamily: 'StamPete',
    fontSize: 24,
    color: ZeplinColors.black,
  );
  static const HeadlineSecondaryBlack20SP = TextStyle(
    fontFamily: 'StamPete',
    fontSize: 20,
    color: ZeplinColors.black,
  );
  static const HeadlineSecondaryWhite20SP = TextStyle(
    fontFamily: 'StamPete',
    fontSize: 20,
    color: ZeplinColors.white,
  );
  static const HeadlineSecondaryBlue20SP = TextStyle(
    fontFamily: 'StamPete',
    fontSize: 20,
    color: ZeplinColors.primary_blue,
  );

  // Subtitles
  static const SubtitlePrimaryWhite14SP = TextStyle(
    fontFamily: 'StamPete',
    fontSize: 16,
    color: ZeplinColors.white,
  );
  static const SubtitlePrimaryBlue16SP = TextStyle(
    fontFamily: 'StamPete',
    fontSize: 16,
    color: ZeplinColors.primary_blue,
  );
  static const SubtitleSecondaryPink16SP = TextStyle(
    fontFamily: 'StamPete',
    fontSize: 16,
    color: ZeplinColors.primary_pink,
  );

  // Body
  static const BodyPrimaryBlack16SP = TextStyle(
    fontFamily: 'ArialMtRegular',
    fontSize: 16,
    color: ZeplinColors.black,
  );
  static const BodyPrimaryGrey16SP = TextStyle(
    fontFamily: 'ArialMtRegular',
    fontSize: 16,
    color: ZeplinColors.grey,
  );
  static const BodySecondaryPink14SP = TextStyle(
    fontFamily: 'ArialMtRegular',
    fontSize: 14,
    color: ZeplinColors.primary_pink,
  );
  static const BodySecondaryBlack14SP = TextStyle(
    fontFamily: 'ArialMtRegular',
    fontSize: 14,
    color: ZeplinColors.black,
  );
  static const BodySecondarySoftBlack14SP = TextStyle(
    fontFamily: 'ArialMtRegular',
    fontSize: 14,
    color: ZeplinColors.soft_black,
  );
  static const BodyPrimaryGrey14SP = TextStyle(
    fontFamily: 'ArialMtRegular',
    fontSize: 14,
    color: ZeplinColors.grey,
  );
  static const BodySecondaryRed14SP = TextStyle(
    fontFamily: 'ArialMtRegular',
    fontSize: 14,
    color: ZeplinColors.error_secondary,
  );

  static const BodySecondaryGreen14SP = TextStyle(
    fontFamily: 'ArialMtRegular',
    fontSize: 14,
    color: ZeplinColors.success,
  );

  // Body BoldCAPS 14SP
  static const BodyBoldCAPSBlue14SP = TextStyle(
      fontFamily: 'arial_mt_bold',
      fontSize: 14,
      color: ZeplinColors.primary_blue,
      fontWeight: FontWeight.bold);
  static const BodyBoldCAPSPink14SP = TextStyle(
      fontFamily: 'arial_mt_bold',
      fontSize: 14,
      color: ZeplinColors.primary_pink,
      fontWeight: FontWeight.bold);
  static const BodyBoldCAPSWhite14SP = TextStyle(
      fontFamily: 'arial_mt_bold',
      fontSize: 14,
      color: ZeplinColors.white,
      fontWeight: FontWeight.bold);
  static const BodyBoldCAPSBlack14SP = TextStyle(
      fontFamily: 'arial_mt_bold',
      fontSize: 14,
      color: ZeplinColors.black,
      fontWeight: FontWeight.bold);

  static const Grey12SP = TextStyle(
    fontFamily: 'arial_mt_bold',
    fontSize: 12,
    color: ZeplinColors.grey,
  );

  static const Black12SP = TextStyle(
    fontFamily: 'arial_mt_bold',
    fontSize: 12,
    color: ZeplinColors.black,
  );

  // Calendar
  static const CalendarBoldGrey16SP = TextStyle(
    fontFamily: 'arial_mt_bold',
    fontSize: 16,
    color: ZeplinColors.grey,
    fontWeight: FontWeight.bold,
  );
  static const CalendarDayWhite = TextStyle(
    fontFamily: 'arial_mt_bold',
    fontSize: 16,
    color: ZeplinColors.white,
  );
  static const CalendarDayBlack = TextStyle(
    fontFamily: 'arial_mt_bold',
    fontSize: 16,
    color: ZeplinColors.black,
  );
}

