import turicreate as turi

# load the dataset
url = "dataset/"
data = turi.image_analysis.load_images(url)
data["foodType"] = data["path"].apply(lambda path: 
    "Amul Kool Strawberry Shake" if "Amul Kool Strawberry Shake" in path else \
    "Amul Milk Shake" if "Amul Milk Shake" in path else \
    "Kurkure Puffcorn Cheese" if "Kurkure Puffcorn Cheese" in path else \
    "Nachos Tomato" if "Nachos Tomato" in path else \

    "Colgate Toothpaste" if "Colgate Toothpaste" in path else \
    "Thuthuvalai Candy" if "Thuthuvalai Candy" in path else \
    "Jaggery" if "Jaggery" in path else \

    "Parle Wafers" if "Parle Wafers" in path else \
    "TATA Gluco Lemon" if "TATA Gluco Lemon" in path else "Other"
)
print(data)

# save the model frame
data.save("model.sframe")
data.explore()

# train model
dataBuffer = turi.SFrame("model.sframe")
trainingBuffers, testingBuffers = dataBuffer.random_split(0.85)
model = turi.image_classifier.create(trainingBuffers, target="foodType", model="resnet-50")
evaluations = model.evaluate(testingBuffers)
print(evaluations["accuracy"])

# save the trained model
model.save("model.model")
model.export_coreml("model.mlmodel")
