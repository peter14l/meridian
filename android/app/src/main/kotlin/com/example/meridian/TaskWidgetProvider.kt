import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import com.example.meridian.R
import org.json.JSONArray

class TaskWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            // Get data from HomeWidget
            val widgetData = HomeWidgetPlugin.getData(context)
            val tasksJson = widgetData.getString("top_tasks", "[]")
            
            val views = RemoteViews(context.packageName, R.layout.widget_layout)
            
            try {
                val tasksArray = JSONArray(tasksJson)
                val taskViewIds = intArrayOf(R.id.task_1, R.id.task_2, R.id.task_3)
                
                for (i in 0 until 3) {
                    if (i < tasksArray.length()) {
                        val task = tasksArray.getJSONObject(i)
                        val title = task.getString("title")
                        views.setTextViewText(taskViewIds[i], "• $title")
                        views.setViewVisibility(taskViewIds[i], View.VISIBLE)
                    } else {
                        views.setViewVisibility(taskViewIds[i], View.GONE)
                    }
                }
            } catch (e: Exception) {
                // Silently fail if JSON is malformed
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
