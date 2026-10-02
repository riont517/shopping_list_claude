import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shopping_list_claude/main.dart';

void main() {
  testWidgets('タイトルが表示される', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('買い物リスト'), findsOneWidget);
    expect(find.text('追加'), findsOneWidget);
  });

  testWidgets('項目を追加できる', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField), '牛乳');
    await tester.tap(find.text('追加'));
    await tester.pump();

    expect(find.text('牛乳'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets('空の入力は追加されない', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField), '   ');
    await tester.tap(find.text('追加'));
    await tester.pump();

    expect(find.byType(Checkbox), findsNothing);
  });

  testWidgets('チェックすると取り消し線が付く', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField), 'パン');
    await tester.tap(find.text('追加'));
    await tester.pump();

    Text text = tester.widget(find.text('パン'));
    expect(text.style?.decoration, isNot(TextDecoration.lineThrough));

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    text = tester.widget(find.text('パン'));
    expect(text.style?.decoration, TextDecoration.lineThrough);
  });

  testWidgets('項目を削除できる', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField), '卵');
    await tester.tap(find.text('追加'));
    await tester.pump();
    expect(find.text('卵'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(find.text('卵'), findsNothing);
  });
}
