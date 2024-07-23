import 'package:flutter/material.dart';
import 'package:final_project_mobile_app_flutter/screens/project_screen/project_details_screen.dart';
import 'package:provider/provider.dart';

import '../../models/project_model.dart';
import '../../providers/project_provider.dart';
import 'add_project_screen.dart';
import 'edit_project_screen.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مشاريعي'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: Provider.of<ProjectProvider>(context, listen: false)
              .getProjects(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('حدث خطأ أثناء جلب المشاريع'));
            } else {
              return Consumer<ProjectProvider>(
                builder: (context, projectProvider, child) {
                  return projectProvider.projects.isEmpty
                      ? Center(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/project.png', height: 100),
                            Text("لايوجد لديك مشاريع",
                                style: TextStyle(fontSize: 20)),
                          ],
                        ))
                      : ListView.builder(
                          itemCount: projectProvider.projects.length,
                          itemBuilder: (context, index) {
                            ProjectModel project =
                                projectProvider.projects[index];
                            return _buildProjectItem(project,
                                context: context,
                                projectProvider: projectProvider);
                          },
                        );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProjectScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildProjectItem(ProjectModel project,
      {required BuildContext context,
      required ProjectProvider projectProvider}) {
    return Dismissible(
      key: Key(project.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        projectProvider.deleteProject(project.id);
      },
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('تأكيد الحذف'),
              content: Text('هل أنت متأكد أنك تريد حذف هذا المشروع؟'),
              actions: [
                TextButton(
                  child: Text('إلغاء'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text('حذف'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProjectDetailsScreen(project: project)),
          );
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      project.description,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProjectScreen(project: project)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
