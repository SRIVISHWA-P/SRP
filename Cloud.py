from flask import Flask, request, jsonify

app = Flask(_name_)

@app.route('/process_task', methods=['POST'])
def process_task():
    task_data = request.get_json()
    print(f"Received task: {task_data}")
    
    result = {
        "status": "processed_on_cloud",
        "details": "Task successfully processed in cloud."
    }
    return jsonify(result)

if _name_ == "_main_":
    app.run(host="0.0.0.0", port=5001)
