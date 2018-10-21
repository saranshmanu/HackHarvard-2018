import turicreate as turi
url = "dataset/"
data = turi.image_analysis.load_images(url)
data["foodType"] = data["path"].apply(lambda path: "CocaCola" if "CocaCola" in path else \
                                                    "M&M" if "M&M" in path else \
                                                    "Yogurt" if "Yogurt" in path else \
                                                    "Muffin" if "Muffin" in path else \
                                                    "Banana" if "Banana" in path else \
                                                    "Cafe Mocha" if "Cafe Mocha" in path else "Other")
print(data)
data.save("rice_or_soup.sframe")
data.explore()

dataBuffer = turi.SFrame("rice_or_soup.sframe")
trainingBuffers, testingBuffers = dataBuffer.random_split(0.85)
model = turi.image_classifier.create(trainingBuffers, target="foodType", model="resnet-50")
evaluations = model.evaluate(testingBuffers)
print evaluations["accuracy"]
model.save("rice_or_soup.model")
model.export_coreml("MODEL.mlmodel")