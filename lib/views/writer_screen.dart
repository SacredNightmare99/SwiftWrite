import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:writer/controllers/writer_controller.dart';
import 'package:writer/utils/constants/file_types.dart';
import 'package:writer/utils/widgets/markdown_view.dart';
import 'package:writer/views/todo_screen.dart';

class WriterScreen extends GetView<WriterController> {
  const WriterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WriterController());
    
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) controller.saveNote();
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: Obx(() => controller.isPreview.value
                ? Text(controller.titleController.text)
                : TextField(
                    controller: controller.titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                      filled: false,
                    ),
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
            actions: [
              Obx(() {
                if (controller.type.value == FileType.markdown) {
                  return IconButton(
                    icon: Icon(controller.isPreview.value ? Icons.visibility_off : Icons.visibility),
                    onPressed: controller.togglePreview,
                  );
                }

                if (controller.type.value == FileType.programmingLanguage) {
                  return IconButton(
                    icon: Obx(() => controller.isLoading.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.play_arrow_rounded)),
                    onPressed: () {
                      controller.isLoading.value ? null : controller.runCode(context);
                    },
                  );
                }

                if (controller.type.value == FileType.unsupported || controller.type.value == FileType.plainText) {
                  return Center(
                    child: Chip(
                      padding: const EdgeInsets.all(0),
                      label: const Text('Plain Text'),
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      side: BorderSide(color: Theme.of(context).dividerColor, width: 2),
                      labelStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                }

                if (controller.type.value == FileType.todo) {
                  return IconButton(
                    icon: Obx(() => Icon(controller.isTodoSourceView.value ? Icons.list_alt : Icons.source)),
                    onPressed: controller.toggleTodoSourceView,
                  );
                }
                
                return const SizedBox.shrink();
              }),
              Obx(() {
                if (controller.type.value != FileType.todo) {
                  return IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () => controller.saveNoteToFile(context),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              Obx(() {
                if (controller.type.value != FileType.todo) {
                  return IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: controller.shareNote,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              })
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              final showPreview = controller.isPreview.value && controller.type.value == FileType.markdown;
              final isTodo = controller.type.value == FileType.todo;

              if (showPreview) {
                 return MarkdownView(
                  data: controller.contentController.text,
                );
              } else if (isTodo) {
                return Obx(() {
                  if (controller.isTodoSourceView.value) {
                    return Column(
                      children: [
                        Expanded(
                          child: TextField(
                            autocorrect: false,
                            keyboardType: TextInputType.multiline,
                            controller: controller.contentController,
                            maxLines: null,
                            expands: true,
                            decoration: const InputDecoration(
                              hintText: 'Start writing...',
                              border: InputBorder.none,
                              filled: false,
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(() => Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: controller.tags.map((tag) {
                                return Chip(
                                  label: Text(tag),
                                  onDeleted: () => controller.removeTag(tag),
                                );
                              }).toList(),
                            )),
                        TextField(
                          controller: controller.tagController,
                          decoration: const InputDecoration(
                            hintText: 'Add a tag...',
                          ),
                          onSubmitted: controller.addTag,
                        ),
                      ],
                    );
                  } else {
                    return TodoScreen(
                      data: controller.contentController.text,
                      onChanged: (newData) {
                        controller.contentController.text = newData;
                      },
                    );
                  }
                });
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: TextField(
                        autocorrect: false,
                        keyboardType: TextInputType.multiline,
                        controller: controller.contentController,
                        maxLines: null,
                        expands: true,
                        decoration: const InputDecoration(
                          hintText: 'Start writing...',
                          border: InputBorder.none,
                          filled: false,
                        ),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() => Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: controller.tags.map((tag) {
                            return Chip(
                              label: Text(tag),
                              onDeleted: () => controller.removeTag(tag),
                            );
                          }).toList(),
                        )),
                    TextField(
                      controller: controller.tagController,
                      decoration: const InputDecoration(
                        hintText: 'Add a tag...',
                      ),
                      onSubmitted: controller.addTag,
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}

