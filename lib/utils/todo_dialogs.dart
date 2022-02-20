import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/dependency_injection.dart';
import 'package:todo_app/cubits/add_todo_cubit.dart';
import 'package:todo_app/cubits/edit_todo_cubit.dart';
import 'package:todo_app/cubits/todos_cubit.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/widgets/todo_list.dart';

class TodoDialog {
  static showEditTodo({required int index, required BuildContext context}) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _dateController = TextEditingController();
    DateTime? d;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [
          TextButton(
              onPressed: () {
                Provider.of<TodoProvider>(context, listen: false).editTodo(
                    title: _titleController.text.isEmpty
                        ? null
                        : _titleController.text,
                    dateTime: d,
                    index: index);
                Navigator.of(ctx).pop();
              },
              child: Text(AppStrings.btnEdit)),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(AppStrings.btnCancel)),
        ],
        title: Text(AppStrings.titleEditTodo),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  hintText: AppStrings.hintTitle,
                  label: Text(AppStrings.labelName)),
            ),
            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: () {
                showDatePicker(
                        initialDatePickerMode: DatePickerMode.year,
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030))
                    .then((value) {
                  d = value;
                  if (value != null)
                    _dateController.text =
                        DateFormat('dd-MM-yyyy').format(value);
                });
              },
              decoration: InputDecoration(
                  hintText: AppStrings.hintDate,
                  label: Text(AppStrings.labelDate)),
            ),
          ],
        ),
      ),
    );
  }

  static showDeleteTodo(
      {required Todo todo,
      required BuildContext ctx,
      }) {
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actions: [
            TextButton(
                onPressed: () {
                  BlocProvider.of<EditTodoCubit>(ctx, listen: false)
                      .deleteTodo(todo: todo);
                  Navigator.of(context).pop();
                },
                child: Text(AppStrings.btnOk)),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppStrings.btnCancel)),
          ],
          title: Text(AppStrings.titleEditTodo),
          content: Text(AppStrings.msgWantToDeleteTodo)),
    );
  }

  static showAddTodo({required BuildContext context}) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _dateController = TextEditingController();
    DateTime? d;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [
          TextButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  BlocProvider.of<AddTodoCubit>(context)
                      .addTodo(_titleController.text, d ?? DateTime.now());
                }
                Navigator.of(ctx).pop();
              },
              child: Text(AppStrings.btnAdd)),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(AppStrings.btnCancel)),
        ],
        title: Text(AppStrings.titleAddTodo),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  hintText: AppStrings.hintTitle,
                  label: Text(AppStrings.labelName)),
            ),
            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: () {
                showDatePicker(
                        initialDatePickerMode: DatePickerMode.year,
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030))
                    .then((value) {
                  d = value;
                  if (value != null)
                    _dateController.text =
                        DateFormat('dd-MM-yyyy').format(value);
                });
              },
              decoration: InputDecoration(
                  hintText: AppStrings.hintDate,
                  label: Text(AppStrings.labelDate)),
            ),
          ],
        ),
      ),
    );
  }
}
